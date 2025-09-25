resource "google_gke_backup_backup_plan" "gke_backup" {
  name = "${var.prefix}-gke-backup"
  cluster = google_container_cluster.gke_cluster.id
  location = var.gcp_region
  retention_policy {
    backup_delete_lock_days = 0  ###30  ### Minimum retention period for backup before this backup can not be deleted.
    backup_retain_days = 7       ###180  ### The number of days a backup should be retained before it's automatically deleted
  }
  backup_schedule {
    cron_schedule = "0 11,23 * * *"  ### Backup scheduled at 11 AM and 11 PM UTC. 
  }
  backup_config {
    include_volume_data = true
    include_secrets = true
    all_namespaces = true           ### Full GKE cluster backup.
  }
}
