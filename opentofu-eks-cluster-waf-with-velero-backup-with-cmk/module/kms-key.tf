resource "aws_kms_key" "aws_ebs_cmk" {
  description              = "AWS KMS key for EBS encryption"
  deletion_window_in_days  = 7
  key_usage                = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  enable_key_rotation      = true
  rotation_period_in_days  = 90
  policy = jsonencode({
    "Version": "2012-10-17",
    "Id": "auto-ebs-eks-2",
    "Statement": [
      {
        "Sid": "Allow access through EBS for all principals in the account that are authorized to use EBS",
        "Effect": "Allow",
        "Principal": {
          "AWS": "*"
        },
        "Action": [
          "kms:Create*",
          "kms:Describe*",
          "kms:Enable*",
          "kms:List*",
          "kms:Put*",
          "kms:Update*",
          "kms:Get*",
          "kms:TagResource",
          "kms:GenerateDataKey",
          "kms:GenerateDataKeyWithoutPlaintext",
          "kms:Encrypt",
          "kms:ReEncrypt*",
          "kms:Decrypt"
        ],
        "Resource": "*",
        "Condition": {
          "StringEquals": {
            "kms:ViaService": ["ec2.${data.aws_region.reg.region}.amazonaws.com", "eks.${data.aws_region.reg.region}.amazonaws.com"],
            "kms:CallerAccount": "${data.aws_caller_identity.G_Duty.account_id}"
          }
        }
      },
      {
        "Sid": "Allow direct access to key metadata to the account",
        "Effect": "Allow",
        "Principal": {
          "AWS": "arn:aws:iam::${data.aws_caller_identity.G_Duty.account_id}:root"
        },
        "Action": [
          "kms:Describe*",
          "kms:Get*",
          "kms:List*",
          "kms:RotateKeyOnDemand",
          "kms:RevokeGrant",
          "kms:PutKeyPolicy",
          "kms:GetKeyPolicy",
          "kms:CreateKey",
          "kms:DescribeKey",
          "kms:Disable*",
          "kms:ScheduleKeyDeletion",
          "kms:EnableKeyRotation",
          "kms:CreateAlias",
          "kms:DeleteAlias"
        ],
        "Resource": "*"
      }
    ]
  })
}

resource "aws_kms_alias" "eks_envelope_encryption" {
  name          = "alias/ebs-eks-envelope-encription-secrets-key"
  target_key_id = aws_kms_key.aws_ebs_cmk.id
}
