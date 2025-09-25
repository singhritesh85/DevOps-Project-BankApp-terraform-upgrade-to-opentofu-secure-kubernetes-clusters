############################ Provide Parameters to create GCP Cloud DNS Zone ###################################

project_name = "XXXX-XXXXXXXX-2XXXX6"  ### Provide the GCP Account Project ID.
gcp_region = ["us-east1", "us-central1", "asia-south2", "asia-south1", "us-west1"]
region = "us-east-2"
prefix = "bankapp"
dns_name = "singhritesh85.com."
dns_zone_visibility = ["public", "private"]
enable_logging = ["true", "false"]
dnssec_state = ["on", "off"]
env  = ["dev", "stage", "prod"]
