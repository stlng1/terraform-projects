

variable "project_name" {
  type = string
}

variable "root_domain_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "region" {
  type = string
}


variable "db_name" {
  type        = string
  description = "the name of the database"
}

variable "data_private_subnets" {
  type = list(any)
}

