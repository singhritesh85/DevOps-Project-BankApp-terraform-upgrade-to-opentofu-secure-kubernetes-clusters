###################################################### Variables for VPC ############################################################

variable "vpc_cidr"{

}

variable "private_subnet_cidr"{

}

variable "public_subnet_cidr"{

}

data "aws_partition" "amazonwebservices" {
}

data "aws_region" "reg" {
}

data "aws_availability_zones" "azs" {
}

data "aws_caller_identity" "G_Duty" {
}

variable "igw_name" {

}

variable "natgateway_name" {

}

variable "vpc_name" {

}

########################################################### Variables for EKS ######################################################################

variable "eks_cluster" {

}

variable "eks_iam_role_name" {

}

variable "node_group_name" {

}

variable "eks_nodegrouprole_name" {

}

variable "launch_template_name" {

}

variable "instance_type" {

}

#variable "eks_ami_id" {

#}

variable "disk_size" {

}

variable "capacity_type" {

}

variable "ami_type" {

}

variable "release_version" {

}

variable "kubernetes_version" {

}

variable "env" {

}

variable "ebs_csi_name" {

}

variable "ebs_csi_version" {

}

variable "csi_snapshot_controller_version" {

}

variable "addon_version_guardduty" {

}

variable "addon_version_kubeproxy" {

}

variable "addon_version_vpc_cni" {

} 

variable "addon_version_coredns" {

}

variable "addon_version_observability" {

}

variable "addon_version_podidentityagent" {

}

variable "addon_version_metrics_server" {

}

########################################### variables to launch EC2 ############################################################

variable "instance_count" {

}

variable "provide_ami" {

}

#variable "vpc_security_group_ids" {

#}

#variable "subnet_id" {

#}

#variable "kms_key_id" {

#}

variable "cidr_blocks" {

}

variable "name" {

}

############################################# Variables to create ALB ############################################################

variable "application_loadbalancer_name" {

}
variable "internal" {

}
variable "load_balancer_type" {

}
#variable "subnets" {

#}
#variable "security_groups" {     ## Security groups are not supported for network load balancers

#}
variable "enable_deletion_protection" {

}
variable "s3_bucket_exists" {

}
variable "access_log_bucket" {

}
variable "prefix" {

}
variable "idle_timeout" {

}
variable "enabled" {

}
variable "target_group_name" {

}
variable "instance_port" {    #### Don't apply when target_type is lambda

}
variable "instance_protocol" {          #####Don't use protocol when target type is lambda

}
variable "target_type_alb" {

}
#variable "vpc_id" {

#}
variable "load_balancing_algorithm_type" {

}
variable "healthy_threshold" {

}
variable "unhealthy_threshold" {

}
variable "healthcheck_path" {

}
#variable "ec2_instance_id" {

#}
variable "timeout" {

}
variable "interval" {

}
variable "ssl_policy" {

}
variable "certificate_arn" {

}
variable "type" {

}
