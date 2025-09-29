############## GCP Key Ring for Envelope Encryption and GKE standard Cluster Encryption ###################
resource "google_kms_key_ring" "gke_key_ring" {
  name     = "dexter-gke-key-ring"    ###"${var.prefix}-gke-key-ring"
  location = "us-central1" 
}

###################################### GKE Disk Encryption Key ############################################
resource "google_kms_crypto_key" "gke_disk_encryption_key" {
  name            = "${var.prefix}-gke-disk-encryption-key"
  key_ring        = google_kms_key_ring.gke_key_ring.id
  purpose         = "ENCRYPT_DECRYPT"
  rotation_period = "7776000s"  # Generate a new CryptoKeyVersion after 90 Days and set it as a primary.
  destroy_scheduled_duration = "86400s"
}

################################## GKE envelope encryption Encryption Key #################################
resource "google_kms_crypto_key" "envelope_encryption_crypto_key" {
  name            = "${var.prefix}-gke-envelope-encryption-key"
  key_ring        = google_kms_key_ring.gke_key_ring.id
  purpose         = "ENCRYPT_DECRYPT"
  rotation_period = "7776000s" # Generate a new CryptoKeyVersion after 90 Days and set it as a primary.
  destroy_scheduled_duration = "86400s"
}
