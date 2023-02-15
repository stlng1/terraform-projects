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

variable "data_private_subnets-1" {
  type = string
  description = "First subnet for the mount target"
}

variable "data_private_subnets-2" {
  type = string
  description = "Second subnet for the mount target"
}

variable "datalayer-sg" {
  description = "webservers security group"
  type        = string
}