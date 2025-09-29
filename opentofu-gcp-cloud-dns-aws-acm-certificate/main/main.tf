module "gcp_cloud_dns_zone_aws_certificate" {

source = "../module"
project_name = var.project_name
encryption_passphrase = var.encryption_passphrase
gcp_region = var.gcp_region
region = var.region
prefix = var.prefix
dns_name = var.dns_name
dns_zone_visibility = var.dns_zone_visibility[0]
enable_logging = var.enable_logging[0] 
dnssec_state = var.dnssec_state[0] 
env  = var.env[0]

}
