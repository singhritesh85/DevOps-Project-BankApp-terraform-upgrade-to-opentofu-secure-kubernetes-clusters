terraform {
  backend "gcs" {
    bucket  = "dolo-dempo"
    prefix  = "state/gke-standard"
  }
}


