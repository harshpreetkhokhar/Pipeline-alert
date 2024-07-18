variable "policy-condition" {
  type = any
}
# type = list(object({
#   typeofcondition      =string
#   aggregation_window   = number
#   aggregation_method   = string
#   aggregation_delay    = number
#   expiration_duration  = number
#   critical = object({
#     operator               = string
#     threshold_occurrences  = string
#     threshold_duration     = string
#     threshold              = number
#   })
#   warning = object({
#     operator               = string
#     threshold_occurrences  = string
#     threshold_duration     = string
#     threshold              = number
#   })
# }))



# variable "query" {
#   type = string
# }

variable "typeofdestination" {
  type = string
}
variable "property-key" {
  type = string
}
variable "property-value" {
  type = string
}
variable "channel-type" {
  type = string
}

variable "channel-product" {
  type = string
}

variable "channel-property-key" {
  type = string
}
variable "channel-property-value" {
  type = string
}
variable "apikey" {
  type = string
}

variable "accountID" {
  type = string
}



variable "alert-workflow" {
  type = list(object({
    muting_rules_handling = string
    predicate = list(object({
      operator  = string
      attribute = string
    }))
    })
  )
}
