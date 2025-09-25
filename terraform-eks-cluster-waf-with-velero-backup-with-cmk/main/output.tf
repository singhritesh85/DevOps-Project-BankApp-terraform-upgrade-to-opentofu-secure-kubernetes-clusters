output "ecr_ec2_private_ip_eks_details" {
  description = "Details of the Elastic Container Registry, Jenkins-Master, Jenkins-Slave Private IP, EKS details Created, IAM Role_ARN and WAFV2_ACL_ARN"
  value       = "${module.eks_cluster}"
}
