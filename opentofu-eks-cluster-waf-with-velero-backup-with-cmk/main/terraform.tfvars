###########Provide Parameters for EKS Cluster and NodeGroup########################

region = "us-east-2"
encryption_passphrase = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"

#prefix = eks

vpc_cidr = "10.10.0.0/16"
private_subnet_cidr = ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24"]
public_subnet_cidr = ["10.10.4.0/24", "10.10.5.0/24", "10.10.6.0/24"]
igw_name = "test-IGW"
natgateway_name = "EKS-NatGateway"
vpc_name = "test-vpc"

eks_cluster = "eks-demo-cluster"
eks_iam_role_name = "eks-iam-role"
node_group_name = "eks-nodegroup"
eks_nodegrouprole_name = "eks-nodegroup-role"
launch_template_name = "eks-launch-template"
#eks_ami_id = ["ami-0f5a11c59a157c25a", "ami-076fda1d45f0f46d7"]
instance_type = ["t3.micro", "t3.small", "t3.medium"]
disk_size = "30"
ami_type = ["AL2023_x86_64_STANDARD", "AL2_x86_64", "CUSTOM"]
release_version = ["1.23.16-20230217", "1.24.10-20230217", "1.25.6-20230217", "1.26.12-20240110", "1.27.9-20240110", "1.28.5-20240110", "1.29.8-20241109", "1.30.4-20241109", "1.31.11-20250804", "1.32.7-20250804", "1.33.0-20250519"]
kubernetes_version = ["1.23", "1.24", "1.25", "1.26", "1.27", "1.28", "1.29", "1.30", "1.31", "1.32", "1.33"]
capacity_type = ["ON_DEMAND", "SPOT"]
env = [ "dev", "stage", "prod" ]
ebs_csi_name = "aws-ebs-csi-driver"
ebs_csi_version         = ["v1.39.0-eksbuild.1", "v1.28.0-eksbuild.1", "v1.27.0-eksbuild.1", "v1.26.1-eksbuild.1", "v1.25.0-eksbuild.1"]        #####"v1.21.0-eksbuild.1"
addon_version_guardduty = ["v1.10.0-eksbuild.2", "v1.9.0-eksbuild.2", "v1.8.1-eksbuild.2", "v1.4.1-eksbuild.2", "v1.4.0-eksbuild.1", "v1.3.1-eksbuild.1", "v1.2.0-eksbuild.3"]
addon_version_kubeproxy = ["v1.32.6-eksbuild.6", "v1.31.10-eksbuild.6", "v1.30.9-eksbuild.3", "v1.28.15-eksbuild.9", "v1.27.10-eksbuild.2", "v1.27.8-eksbuild.4", "v1.27.8-eksbuild.1", "v1.27.6-eksbuild.2"]
addon_version_vpc_cni   = ["v1.19.2-eksbuild.5", "v1.16.3-eksbuild.2", "v1.16.0-eksbuild.1", "v1.15.5-eksbuild.1", "v1.15.1-eksbuild.1"]
addon_version_coredns   = ["v1.11.4-eksbuild.2", "v1.10.1-eksbuild.18", "v1.10.1-eksbuild.7", "v1.10.1-eksbuild.6", "v1.10.1-eksbuild.5", "v1.10.1-eksbuild.4"]
csi_snapshot_controller_version = ["v8.2.0-eksbuild.1", "v8.1.0-eksbuild.2", "v8.1.0-eksbuild.1", "v7.0.1-eksbuild.1", "v6.3.2-eksbuild.1"]
addon_version_observability = ["v4.1.0-eksbuild.1", "v4.0.0-eksbuild.1", "v3.7.0-eksbuild.1", "v3.5.0-eksbuild.1"]
addon_version_podidentityagent = ["v1.3.7-eksbuild.2", "v1.3.5-eksbuild.2", "v1.3.4-eksbuild.1", "v1.3.0-eksbuild.1", "v1.2.0-eksbuild.1"]
addon_version_metrics_server = ["v0.7.2-eksbuild.3", "v0.7.2-eksbuild.2", "v0.7.2-eksbuild.1"]

##############################Parameters to launch EC2#############################

instance_count = 1
provide_ami = {
  "us-east-1" = "ami-0a1179631ec8933d7"
  "us-east-2" = "ami-0169aa51f6faf20d5"
  "us-west-1" = "ami-0e0ece251c1638797"
  "us-west-2" = "ami-086f060214da77a16"
}
#subnet_id = "subnet-XXXXXXXXXXXXXXXXX"
#vpc_security_group_ids = ["sg-00cXXXXXXXXXXXXX9"]
cidr_blocks = ["0.0.0.0/0"]
name = "Jenkins"

#kms_key_id = "arn:aws:kms:us-east-2:02XXXXXXXXX6:key/XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"   ### Provide the ARN of KMS Key.

################################Parameters to create ALB############################

application_loadbalancer_name = "jenkins-ms"
internal = false
load_balancer_type = "application"
#subnets = ["subnet-XXXXXXXXXXXXXXXXX", "subnet-XXXXXXXXXXXXXXXXX", "subnet-XXXXXXXXXXXXXXXXX"]
#security_groups = ["sg-05XXXXXXXXXXXXXXc"]  ## Security groups are not supported for network load balancer
enable_deletion_protection = false
s3_bucket_exists = false   ### Select between true and false. It true is selected then it will not create the s3 bucket. 
access_log_bucket = "s3bucketcapturealblogjenkins" ### S3 Bucket into which the Access Log will be captured
prefix = "application_loadbalancer_log_folder"
idle_timeout = 60
enabled = true
target_group_name = "jenkins"
instance_port = 8080
instance_protocol = "HTTP"          #####Don't use protocol when target type is lambda
target_type_alb = ["instance", "ip", "lambda"]
#vpc_id = "vpc-XXXXXXXXXXXXXXXXX"
#ec2_instance_id = ""
load_balancing_algorithm_type = ["round_robin", "least_outstanding_requests"]
healthy_threshold = 2
unhealthy_threshold = 2
timeout = 3
interval = 30
healthcheck_path = "/login"
ssl_policy = ["ELBSecurityPolicy-2016-08", "ELBSecurityPolicy-TLS-1-2-2017-01", "ELBSecurityPolicy-TLS-1-1-2017-01", "ELBSecurityPolicy-TLS-1-2-Ext-2018-06", "ELBSecurityPolicy-FS-2018-06", "ELBSecurityPolicy-2015-05"]
certificate_arn = "arn:aws:acm:us-east-2:02XXXXXXXXX6:certificate/XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"
type = ["forward", "redirect", "fixed-response"]
