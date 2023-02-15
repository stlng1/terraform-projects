variable "ami_base" {
  type        = string
  description = "AMI image_ids for the launch templates"
}

variable "project_name" {
    type = string
    description = "name of the project"
}

variable "compute-sg" {
    description = "security group for compute instances"
    type = string
    default = "ACS-sg"
}

variable "keypair" {
    type = string
    description = "keypair for instances"
}

variable "public_subnets-1" {
  type        = string
  description = "public subnets"
}

variable "tags" {
  description = "A mapping of tags to assign to all resources."
  type        = map(string)
  default     = {}
}