########################################## AWS WAFV2 ACL Rule for Rate Limit ####################################################

resource "aws_wafv2_web_acl" "wafv2_rate_limit" {
  name        = "aws-wafv2-rate-limit"
  description = "Web-Application-Firewall-for-RateLimit"
  scope       = "REGIONAL"

  default_action {  ### Action to be performed if none of the rules contained in the WebACL match
    allow {}
  }

  rule {
    name     = "rate-limit"
    priority = 1  ### Lower the priority value, higher will be priority.

    action {
      block {
        custom_response {
          custom_response_body_key = "blocked_request_custom_response"
          response_code            = 429
        }
      }
    }

    statement {
      rate_based_statement {
        limit              = 40
        aggregate_key_type = "IP"

#        scope_down_statement {
#          geo_match_statement {
#            country_codes = ["US", "NL"]
#          }
#        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "wafv2-rate-limit-rule-metric"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "captcha-rule"
    priority = 2 
    action {
      captcha {}
    }
    statement {
      rate_based_statement {
        limit              = 30
        aggregate_key_type = "IP"
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "captcha-rule-metric"
      sampled_requests_enabled   = true
    }
  }

  captcha_config {
    immunity_time_property {
      immunity_time = 60  ### In 60 seconds if request to access the website more than 30 then captcha applies.
    }
  } 

  rule {
    name     = "AWS-AWSManagedRulesSQLiRuleSet"
    priority = 0  ### Lower the priority value, higher will be priority.

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesSQLiRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWS-AWSManagedRulesSQLiRuleSet"
      sampled_requests_enabled   = true
    }
  }
  
  rule {
    name     = "Block-Cross-Site-Scripting"
    priority = 3
    action {
      block {}
    }
    statement {
      xss_match_statement {
        field_to_match {
          body {}
        }
        text_transformation {
          priority = 0
          type     = "HTML_ENTITY_DECODE"
        }
        text_transformation {
          priority = 1
          type     = "URL_DECODE"
        }
        text_transformation {
          priority = 2
          type     = "COMPRESS_WHITE_SPACE"
        }
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "BlockXSSInBodyMetric"
      sampled_requests_enabled   = true
    }
  }

  custom_response_body {
    key          = "blocked_request_custom_response"
    content      = "{\n    \"error\":\"Too Many Requests.\"\n}"
    content_type = "APPLICATION_JSON"
  }

  tags = {
    Environment = var.env
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "wafv2-rate-limit-metric"
    sampled_requests_enabled   = true
  }
}

####################################### Log Group to capture Logs of AWS WAFV2 ACL ##########################################

resource "aws_cloudwatch_log_group" "aws_wafv2_web_acl_log_group" {
  name              = "aws-waf-logs-wb-acl-wafv2"
  retention_in_days = 30   ### The number of days log events will be ratained in the specified log group.
}

resource "aws_wafv2_web_acl_logging_configuration" "aws_wafv2_web_acl_logging_rate_limit" {
  log_destination_configs = [aws_cloudwatch_log_group.aws_wafv2_web_acl_log_group.arn]
  resource_arn            = aws_wafv2_web_acl.wafv2_rate_limit.arn
}
