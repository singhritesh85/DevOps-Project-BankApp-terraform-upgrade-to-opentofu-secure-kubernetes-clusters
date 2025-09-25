provider "azurerm" {
  subscription_id = "5XXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"
  tenant_id = "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"
  features {
    
    log_analytics_workspace {
      permanently_delete_on_destroy = true
    }

    resource_group {
      prevent_deletion_if_contains_resources = true    ### All the Resources within the Resource Group must be deleted before deleting the Resource Group.
    }
   
    virtual_machine {
      delete_os_disk_on_deletion = true
    }

    key_vault {
      purge_soft_delete_on_destroy = true
      recover_soft_deleted_key_vaults = true
    }   
 
  }
}


############ If Resource Provider Microsoft.KubernetesConfiguration already registered in subscription then no need to write below section ############
#resource "azurerm_resource_provider_registration" "kubernetes_configuration" {
#  name = "Microsoft.KubernetesConfiguration"
#}
