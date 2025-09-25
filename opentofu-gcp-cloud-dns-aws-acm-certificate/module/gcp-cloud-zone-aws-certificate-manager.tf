################################# GCP Cloud Zone #########################################

resource "google_dns_managed_zone" "dexter_public_zone" {
  name        = "${var.prefix}-public-zone"
  dns_name    = var.dns_name
  description = "Public"
  visibility  = var.dns_zone_visibility

  cloud_logging_config {
    enable_logging = var.enable_logging
  }

  dnssec_config {
    state = var.dnssec_state
  }
}

############################################# Wild Card ACM Certificate ###############################################

resource "aws_acm_certificate" "acm_cert" {
  domain_name       = "*.singhritesh85.com"
  validation_method = "DNS"

  tags = {
    Environment = var.env
  }
}

############################################# Record Set for Certificate Validation ###################################

resource "google_dns_record_set" "record_cert_validation" {
  managed_zone = google_dns_managed_zone.dexter_public_zone.name
  name    = tolist(aws_acm_certificate.acm_cert.domain_validation_options).0.resource_record_name
  type    = tolist(aws_acm_certificate.acm_cert.domain_validation_options).0.resource_record_type
  rrdatas = [tolist(aws_acm_certificate.acm_cert.domain_validation_options).0.resource_record_value]
  ttl     = 60
}

############################################# AWS ACM Certificate Validation ##########################################

resource "aws_acm_certificate_validation" "acm_certificate_validation" {
  certificate_arn         = aws_acm_certificate.acm_cert.arn
  validation_record_fqdns = [google_dns_record_set.record_cert_validation.name]
}
