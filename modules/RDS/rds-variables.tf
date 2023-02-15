variable "tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
  default     = {}
}

variable "master-username" {
  type        = string
  description = "RDS admin username"
}

variable "master-password" {
  type        = string
  description = "RDS master password"
}

variable "db_name" {
  type        = string
  description = "the name of the database"
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