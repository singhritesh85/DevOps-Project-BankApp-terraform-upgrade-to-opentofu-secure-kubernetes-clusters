output "gcp_cloud_dns_zone_and_aws_cerificate_arn_details" {
  description = "GCP Cloud Zone ID, Nameserver and ACM Certificate ARN"
  value       = "${module.gcp_cloud_dns_zone_aws_certificate}"
}
