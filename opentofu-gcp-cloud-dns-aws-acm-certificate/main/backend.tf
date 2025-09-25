terraform {
  backend "gcs" {
    bucket  = "dolo-dempo"
    prefix  = "state/cloud-dns"
  }
  encryption {
#    method "unencrypted" "read_unencrypted_state" {} ### To read unencrypted state file

    key_provider "pbkdf2" "statefile_encryption_password" {
      passphrase = var.encryption_passphrase
    }

    method "aes_gcm" "passphrase" {
      keys = key_provider.pbkdf2.statefile_encryption_password
    }

    state {
      method = method.aes_gcm.passphrase
#      fallback {
#        method = method.unencrypted.read_unencrypted_state
#      }
    }

    plan {
      method = method.aes_gcm.passphrase
#      fallback {
#        method = method.unencrypted.read_unencrypted_state
#      }
    }

  }
}
