variable "root_domain_name" {
    type = string
    description = "internet domain name"
}

variable "domain_subnets" {
    type = list(any)
    description = "list of domain subnets"
}

# variable "domain_certificate" {
#     type = string
#     description = "name of certificate using wildcard for all the domains created in root domain name"
# }

variable "name" {
  type    = string
  default = "ACS"

}

variable "tags" {
  description = "A mapping of tags to assign to all resources."
  type        = map(string)
  default     = {}
}

variable "project_phase_name" {
  description = "The name to use for all resources"
  type        = string
}