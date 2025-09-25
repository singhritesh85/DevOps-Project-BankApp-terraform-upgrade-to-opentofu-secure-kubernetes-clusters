output "registry_id" {
  description = "Registry ID of repository"
  value       = aws_ecr_repository.ecr.registry_id
}
output "repository_url" {
  description = "The URL of Repository"
  value       = aws_ecr_repository.ecr.repository_url
}
output "alb_dns_name" {
  description = "The DNS name of the Jenkins Application Load Balancer."
  value       = aws_lb.test-application-loadbalancer.dns_name
}
output "jenkins_master_instance_id" {
  description = "The ID of the Jenkins Master EC2 instance."
  value       = aws_instance.jenkins_master.id
}
output "jenkins_slave_instance_id" {
  description = "The ID of the Jenkins Slave EC2 instance."
  value       = aws_instance.jenkins_slave.id
}
output "jenkins_master_private_ip" {
  description = "The private IP address of the Jenkins Master EC2 instance."
  value       = aws_instance.jenkins_master.private_ip
}
output "jenkins_slave_private_ip" {
  description = "The private IP address of the Jenkins Slave EC2 instance."
  value       = aws_instance.jenkins_slave.private_ip
}
output "eks_cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = aws_eks_cluster.eksdemo.endpoint
}
output "eks_cluster_name" {
  description = "Name of the EKS cluster"
  value       = aws_eks_cluster.eksdemo.name
}
output "velero_backup_iam_role_arn" {
  description = "IAM Role ARN for Velero Backup"
  value       = aws_iam_role.eks_velero_backup_role.arn 
}
output "alb_ingress_controller_role_arn" {
  description = "IAM Role ARN for ALB Ingress Controller"
  value       = aws_iam_role.aws_alb_ingress_controller_role.arn
}
output "velero_backup_s3_bucket_name" {
  description = "S3 Bucket Name for Velero Backup"
  value       = aws_s3_bucket.s3_bucket_velero[0].bucket
}
output "karpenter_node_spun_iam_role_arn" {
  description = "IAM Role ARN for Karpenter to spin-up nodes"
  value       = aws_iam_role.karpenter_node_iam_role.arn
}
output "aws_wafv2_web_acl_arn" {
  description = "The ARN of the WafV2 Web ACL."
  value       = aws_wafv2_web_acl.wafv2_rate_limit.arn
}
