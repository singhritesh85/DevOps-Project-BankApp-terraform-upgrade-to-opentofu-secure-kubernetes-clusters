output "cloud_dns_zone_id" {
  description = "The ID of the GCP Cloud DNS Zone."
  value       = google_dns_managed_zone.dexter_public_zone.id
}

output "gcp_cloud_dns_zone_name_servers" {
  description = "The name servers for the GCP Cloud DNS Zone."
  value       = google_dns_managed_zone.dexter_public_zone.name_servers
}

output "certificate_arn" {
  description = "The AWS ACM Certificate ARN"
  value = aws_acm_certificate.acm_cert.arn
}
