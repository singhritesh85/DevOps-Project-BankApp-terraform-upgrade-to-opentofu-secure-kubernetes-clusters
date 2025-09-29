############################# Creation of GCP Backup Vault ################################
resource "google_backup_dr_backup_vault" "backup_vault_gcp_vm" {
  location = var.gcp_region
  backup_vault_id    = "${var.prefix}-backup-vault"
  description = "Backup Vault for VM Instances"
  backup_minimum_enforced_retention_duration = "100000s"   ### The minimum enforced retention for each backup within the backup vault.
  labels = {
    foo = "bar1"
  }
  force_update = "true"
  access_restriction = "WITHIN_ORGANIZATION"
  backup_retention_inheritance = "INHERIT_VAULT_RETENTION"
  ignore_inactive_datasources = "true"
  ignore_backup_plan_references = "true"
  allow_missing = "true"
}

############################# Creation of GCP Backup Plan #################################
resource "google_backup_dr_backup_plan" "gcp_vm_backup_plan" {
  location       = var.gcp_region
  backup_plan_id = "${var.prefix}-backup-plan"
  resource_type  = "compute.googleapis.com/Instance"
  backup_vault   = google_backup_dr_backup_vault.backup_vault_gcp_vm.id

  backup_rules {
    rule_id                = "vm-backup-rule"
    backup_retention_days  = 30

    standard_schedule {
      recurrence_type     = "HOURLY"
      hourly_frequency    = 12
      time_zone           = "UTC"

      backup_window {
        start_hour_of_day = 0
        end_hour_of_day   = 24
      }
    }
  }
}
