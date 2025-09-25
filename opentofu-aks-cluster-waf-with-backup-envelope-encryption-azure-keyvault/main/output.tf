#output "acr" {
#  description = "URL of the Azure Container Registry Created"
#  value       = "${module.aks}"
#}

output "acr_azurevm_private_ip_and_aks_details_waf_policy_name_and_application_gateway_name" {
  description = "URL of the Azure Container Registry Created, Private IP Addresses for Azure VM for DevOps Agent, AKS ID, Name, WAF Policy Name and Azure Application Gateway Name"
  value       = "${module.aks}"
}
