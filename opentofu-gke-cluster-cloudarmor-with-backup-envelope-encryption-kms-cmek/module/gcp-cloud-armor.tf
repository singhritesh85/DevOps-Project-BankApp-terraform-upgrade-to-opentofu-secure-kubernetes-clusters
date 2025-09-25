####################################################### GCP Cloud Armor Policy ################################################################

resource "google_compute_security_policy" "gke_cloud_armor_policy" {
  name        = "${var.prefix}-gke-cloud-armor-policy"
  description = "GKE Cloud Armor Policy"

  rule {
    action   = "deny"
    priority = "0"
    match {
      expr {
        expression = "evaluatePreconfiguredWaf('sqli-v33-stable', {'sensitivity': 1})"
      }
    }
    description = "Block SQL Injections"
  }

  rule {
    action   = "throttle"  ###"rate_based_ban"
    priority = "1"  ### Lowest numeic has highest priority.
    description = "Rate limit based on IP"
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = ["0.0.0.0/0"]
      }
    }
    rate_limit_options {
      conform_action = "allow"
      exceed_action  = "deny(429)" # Return 429 Too Many Requests
      enforce_on_key = "ALL" # Or "HTTP_HEADER", "COOKIE", etc.
#      ban_duration_sec = 60   ### can be only used when action = "rate_based_ban"
      rate_limit_threshold {
        count = 40
        interval_sec = 60
      }
    }
  }

  rule {
    action   = "deny"
    priority = "2"
    match {
      expr {
        expression = "evaluatePreconfiguredWaf('xss-v33-stable', {'sensitivity': 1})"
      }
    }
    description = "Block Cross Site Attack"
  } 
  
  rule {
    action = "allow"
    priority = "2147483647"
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = ["*"]
      }
    }
    description = "Default rule to allow all"
  }
}
