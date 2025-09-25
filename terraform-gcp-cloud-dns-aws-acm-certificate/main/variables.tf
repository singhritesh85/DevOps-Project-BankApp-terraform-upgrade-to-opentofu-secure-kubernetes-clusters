########################################### Variables to create Cloud DNS Zone and AWS ACM Certificate ################################################

variable "project_name" {
  description = "Provide the project name in GCP Account"
  type = string
}

variable "gcp_region" {
  description = "Provide the GCP Region in which Resources to be created"
  type = list
}

variable "prefix" {
  type = string
  description = "Provide a prefix name for GCP Cloud DNS Zone to be created"
}

variable "region" {
  type = string
  description = "Provide the AWS Region into which AWS Certificate to be created"
}

variable "dns_name" {
  description = "Provide the name of the Cloud DNS Zone"
  type = string
}

variable "dns_zone_visibility" {
  description = "Select the DNS Zone Visibility between Public and Private"
  type = list
}

variable "enable_logging" {
  description = "Select do you want to enable or disable the logging"
  type = list
}

variable "dnssec_state" {
  description = "Select do you want to enable or disable the dnssec"
  type = list
}

variable "env" {
  description = "Provide the Environment Name."
  type = list
}
