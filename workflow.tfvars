alert-workflow = [{
  muting_rules_handling = "NOTIFY_ALL_ISSUES"
  predicate = [
    {
      operator  = "EXACTLY_MATCHES"
      attribute = "labels.policyIds"
    },
    {
      operator  = "EXACTLY_MATCHES"
      attribute = "priority"

  }]
}]




property-key           = "email"
typeofdestination      = "EMAIL"
property-value         = "kharshpreet13@gmail.com"
channel-type           = "EMAIL"
channel-product        = "IINT"
channel-property-key   = "alert"
channel-property-value = "transaction took too longg"





# alert-workflow = [
#   {
#     muting_rules_handling = "NOTIFY_ALL_ISSUES"
#     predicate = [
#       {
#         operator  = "EXACTLY_MATCHES"
#         attribute = "labels.policyIds"
#       },
#       {
#         operator  = "EXACTLY_MATCHES"
#         attribute = "priority"
#       }
#     ]
#   }
# ]
