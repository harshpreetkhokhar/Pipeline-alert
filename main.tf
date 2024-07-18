// entities
data "newrelic_entity" "app" {
  name   = "Foodme-test"
  domain = "APM"
  type   = "APPLICATION"
  tag {
    key   = "accountId"
    value = var.accountID
  }
}

# locals {
#   custom_tags = {
#     "owner" = "harsh"
#     "mail"  = "xyz@gmail.com"
#   }
# }

# resource "newrelic_entity_tags" "foo" {
#   guid = data.newrelic_entity.app.guid
#   dynamic "tag" {
#     for_each = local.custom_tags
#     content {
#       key    = tag.key
#       values = [tag.value]
#     }
#   }
# }


//alert- policy,condition and muting rule

resource "newrelic_alert_policy" "Policy1" {
  name = "tf-policy"
}

resource "newrelic_nrql_alert_condition" "condition" {
  for_each    = var.policy-condition
  account_id  = var.accountID
  policy_id   = newrelic_alert_policy.Policy1.id
  type        = each.value.typeofcondition
  name        = "tf-condition"
  description = "Alert when transactions are taking too long"
  #   runbook_url                    = "https://www.example.com"
  enabled = true
  #   violation_time_limit_seconds   = 3600
  #   fill_option                    = "static"
  #   fill_value                     = 0
  aggregation_window  = each.value.aggregation_window
  aggregation_method  = each.value.aggregation_method
  aggregation_delay   = each.value.aggregation_delay
  expiration_duration = each.value.expiration_duration
  #   open_violation_on_expiration   = true
  #   close_violations_on_expiration = true
  slide_by = 30

  nrql {
    query = each.value.query
  }

  critical {
    operator              = each.value.operator
    threshold             = each.value.threshold
    threshold_duration    = each.value.threshold_duration
    threshold_occurrences = each.value.threshold_occurrences
  }

  warning {
    operator              = each.value.operator
    threshold             = each.value.threshold
    threshold_duration    = each.value.threshold_duration
    threshold_occurrences = each.value.threshold_occurrences
  }
}
resource "newrelic_workflow" "workflow" {
  for_each              = { for idx, channel in var.alert-workflow : idx => channel }
  name                  = "workflow-tf"
  muting_rules_handling = each.value.muting_rules_handling

  issues_filter {
    name = "Filter-name"
    type = "FILTER"

    predicate {
      attribute = each.value.predicate[0].attribute
      operator  = each.value.predicate[0].operator
      values    = [newrelic_alert_policy.Policy1.id]
    }
    predicate {
      attribute = each.value.predicate[1].attribute
      operator  = each.value.predicate[1].operator
      values    = ["HIGH"]
    }
  }

  destination {
    channel_id = newrelic_notification_channel.channel.id
  }
}
resource "newrelic_notification_destination" "mailpoint" {
  account_id = var.accountID
  name       = "email-destination"
  type       = var.typeofdestination

  property {
    key   = var.property-key
    value = var.property-value
  }
}
resource "newrelic_notification_channel" "channel" {
  account_id     = var.accountID
  name           = "channel-to-destination"
  type           = var.channel-type
  destination_id = newrelic_notification_destination.mailpoint.id
  product        = var.channel-product // (Workflows)


  property {
    key   = var.channel-property-key
    value = var.channel-property-value
  }
}