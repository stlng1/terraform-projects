variable "root_domain_name" {
    type = string
    description = "internet domain name"
}

variable "domain_subnet_1" {
  type        = string
  description = "list of domain subnets"
}

variable "domain_subnet_2" {
  type        = string
  description = "list of domain subnets"
}

variable "public_subnets-1" {
  type        = string
  description = "public subnets"
}

variable "public_subnets-2" {
  type        = string
  description = "public subnets"
}

variable "compute_private_subnets-1" {
  type        = string
  description = "compute private subnets"
}

variable "compute_private_subnets-2" {
  type        = string
  description = "compute private subnets"
}

variable "vpc_id" {
    type = string
    description = "vpc_id"
}

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

variable "privateALB-sg" {
  description = "private alb security group"
  type        = string
}

variable "publicALB-sg" {
  description = "public alb security group"
  type        = string
}

