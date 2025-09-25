module "eks_cluster" {
  source = "../module"

########################################### To create VPC, EKS Cluster and NodeGroup ##################################################

  vpc_cidr = var.vpc_cidr
  private_subnet_cidr = var.private_subnet_cidr
  public_subnet_cidr = var.public_subnet_cidr
  igw_name = var.igw_name
  natgateway_name = var.natgateway_name
  vpc_name = var.vpc_name

  eks_cluster = var.eks_cluster
  eks_iam_role_name = var.eks_iam_role_name
  node_group_name = var.node_group_name
  eks_nodegrouprole_name = var.eks_nodegrouprole_name    
  launch_template_name = var.launch_template_name
#  eks_ami_id = var.eks_ami_id
  instance_type = var.instance_type
  disk_size = var.disk_size
  ami_type = var.ami_type
  release_version = var.release_version
  kubernetes_version = var.kubernetes_version
  capacity_type = var.capacity_type
  env = var.env[0]
  ebs_csi_name = var.ebs_csi_name

  ebs_csi_version         = var.ebs_csi_version[0]
  csi_snapshot_controller_version = var.csi_snapshot_controller_version[0]
  addon_version_guardduty = var.addon_version_guardduty[0]
  addon_version_kubeproxy = var.addon_version_kubeproxy[0]
  addon_version_vpc_cni   = var.addon_version_vpc_cni[0]
  addon_version_coredns   = var.addon_version_coredns[0]
  addon_version_observability = var.addon_version_observability[0]
  addon_version_podidentityagent = var.addon_version_podidentityagent[0]
  addon_version_metrics_server   = var.addon_version_metrics_server[0]

  ###########################To Launch EC2###################################

  instance_count = var.instance_count
  provide_ami = var.provide_ami["us-east-2"]
#  vpc_security_group_ids = var.vpc_security_group_ids
  cidr_blocks = var.cidr_blocks
#  subnet_id = var.subnet_id
#  kms_key_id = var.kms_key_id
  name = var.name

###########################To create ALB###################################

  application_loadbalancer_name = var.application_loadbalancer_name
  internal = var.internal
  load_balancer_type = var.load_balancer_type
#  subnets = var.subnets
#  security_groups = var.security_groups  ## Security groups are not supported for network load balancer
  enable_deletion_protection = var.enable_deletion_protection
  s3_bucket_exists = var.s3_bucket_exists
  access_log_bucket = var.access_log_bucket  ### S3 Bucket into which the Access Log will be captured
  prefix = var.prefix
  idle_timeout = var.idle_timeout
  enabled = var.enabled
  target_group_name = var.target_group_name
  instance_port = var.instance_port
  instance_protocol = var.instance_protocol          #####Don't use protocol when target type is lambda
  target_type_alb = var.target_type_alb[0]
  healthcheck_path = var.healthcheck_path
#  vpc_id = var.vpc_id
#  ec2_instance_id = var.ec2_instance_id
  load_balancing_algorithm_type = var.load_balancing_algorithm_type[0]
  healthy_threshold = var.healthy_threshold
  unhealthy_threshold = var.unhealthy_threshold
  timeout = var.timeout
  interval = var.interval
  ssl_policy = var.ssl_policy[0]
  certificate_arn = var.certificate_arn
  type = var.type 

}

