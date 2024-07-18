

policy-condition = {
  "0" = {
    typeofcondition       = "static"
    aggregation_window    = 60
    aggregation_method    = "event_flow"
    aggregation_delay     = 120
    expiration_duration   = 120
    operator              = "above"
    threshold_occurrences = "ALL"
    threshold             = 5.5
    threshold_duration    = 300
    operator              = "above"
    threshold_occurrences = "ALL"
    threshold             = 3.5
    threshold_duration    = 600
    query = "SELECT average(duration) FROM Transaction where appName = 'Foodme-test' "
  }
}




