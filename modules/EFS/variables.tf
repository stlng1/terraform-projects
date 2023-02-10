# variable "account_no" {
#   type        = number
#   description = "the account number"
# }

variable "tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
  default     = {}
}

variable "user_arn" {
  type = string
}

variable "access_point" {
  type = list(any)
  description = "efs access point"
}
