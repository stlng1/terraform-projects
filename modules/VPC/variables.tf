variable "region" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "enable_dns_support" {
  type = bool
}

variable "enable_dns_hostnames" {
  type = bool
}

# variable "enable_classiclink" {
#   type = bool
# }

# variable "enable_classiclink_dns_support" {
#   type = bool
# }

variable "public_subnets" {
  type = list(any)
}

variable "compute_private_subnets" {
  type = list(any)
}

variable "data_private_subnets" {
  type = list(any)
}

variable "tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
  default     = {}
}






# variable "preferred_number_of_public_subnets" {
#   type = number
# }

# variable "preferred_number_of_private_subnets" {
#   type = number
# }

variable "name" {
  type    = string
  default = "ACS"

}
variable "environment" {
  default = "true"
}