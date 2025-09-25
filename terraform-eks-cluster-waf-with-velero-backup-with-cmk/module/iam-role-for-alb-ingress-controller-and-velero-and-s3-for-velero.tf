############################################# IAM Role for ALB Ingress Controller #######################################################

data "aws_iam_policy_document" "alb_ingress_controller_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.eksopidc.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:aws-load-balancer-controller"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.eksopidc.arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "aws_alb_ingress_controller_role" {
  assume_role_policy = data.aws_iam_policy_document.alb_ingress_controller_assume_role_policy.json
  name               = "aws-alb-ingress-controller-role"
}

resource "aws_iam_policy" "aws_alb_ingress_controller_policy" {
  policy = file("AWSALBIngressController-Policy.json")
  name   = "AWSALBIngressController-Policy"
}

resource "aws_iam_role_policy_attachment" "aws_alb_ingress_controller_policy_attach" {
  role       = aws_iam_role.aws_alb_ingress_controller_role.name
  policy_arn = aws_iam_policy.aws_alb_ingress_controller_policy.arn
}

################################################### S3 Bucket for velero Backup ##############################################################

#S3 Bucket to capture velero backups
resource "aws_s3_bucket" "s3_bucket_velero" {
  count = var.s3_bucket_exists == false ? 1 : 0
  bucket = "dexter-velero-backup"

  force_destroy = true

  tags = {
    Environment = var.env
  }
}

#S3 Bucket Server Side Encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "s3bucket_encryption_velero" {
  count = var.s3_bucket_exists == false ? 1 : 0
  bucket = aws_s3_bucket.s3_bucket_velero[0].id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "AES256"
    }
  }
}

################################################### IAM Role for Velero Backup ###############################################################

data "aws_iam_policy_document" "velero_backup_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.eksopidc.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:velero:velero-server"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.eksopidc.arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "eks_velero_backup_role" {
  assume_role_policy = data.aws_iam_policy_document.velero_backup_assume_role_policy.json
  name               = "eks-velero-backup-role"
}

resource "aws_iam_policy" "eks_velero_backup_policy" {
  name        = "eks-velero-backup-policy"
  description = "Policy for Velero to access S3 and create volume snapshots"
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeVolumes",
                "ec2:DescribeSnapshots",
                "ec2:CreateTags",
                "ec2:CreateVolume",
                "ec2:CreateSnapshot",
                "ec2:DeleteSnapshot"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "s3:DeleteObject",
                "s3:PutObject",
                "s3:AbortMultipartUpload",
                "s3:ListMultipartUploadParts"
            ],
            "Resource": [
                "arn:aws:s3:::${aws_s3_bucket.s3_bucket_velero[0].bucket}/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket"
            ],
            "Resource": [
                "arn:aws:s3:::${aws_s3_bucket.s3_bucket_velero[0].bucket}"
            ]
        }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_velero_policy_attach" {
  role       = aws_iam_role.eks_velero_backup_role.name
  policy_arn = aws_iam_policy.eks_velero_backup_policy.arn
}

