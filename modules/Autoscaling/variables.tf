variable "ami" {
  type        = string
  description = "AMI ID for the launch template"
}

variable "keypair" {
  type        = string
  description = "key pair for the instances"
}

variable "tags" {
  description = "A mapping of tags to assign to all resources."
  type        = map(string)
  default     = {}
}

variable "max_size_nginx-asg" {
  type        = number
  description = "defines the max_size for nginx asg instances"
}

variable "min_size_nginx-asg" {
  type        = number
  description = "defines the min_size for nginx asg instances"
}

variable "capacity_nginx-asg" {
  type        = number
  description = "defines the desired capacity for nginx asg instances"
}

variable "health_grace_period_nginx-asg" {
  type        = number
  description = "defines the health_check_grace_period for nginx asg instances"
}

variable "max_size_bastion-asg" {
  type        = number
  description = "defines the max_size for bastion asg instances"
}

variable "min_size_bastion-asg" {
  type        = number
  description = "defines the min_size for bastion asg instances"
}

variable "capacity_bastion-asg" {
  type        = number
  description = "defines the desired capacity for bastion asg instances"
}

variable "health_grace_period_bastion-asg" {
  type        = number
  description = "defines the health_check_grace_period for bastion asg instances"
}

variable "max_size_wordpress-asg" {
  type        = number
  description = "defines the max_size for wordpress asg instances"
}

variable "min_size_wordpress-asg" {
  type        = number
  description = "defines the min_size for wordpress asg instances"
}

variable "capacity_wordpress-asg" {
  type        = number
  description = "defines the desired capacity for wordpress asg instances"
}

variable "health_grace_period_wordpress-asg" {
  type        = number
  description = "defines the health_check_grace_period for wordpress asg instances"
}

variable "max_size_tooling-asg" {
  type        = number
  description = "defines the max_size for tooling asg instances"
}

variable "min_size_tooling-asg" {
  type        = number
  description = "defines the min_size for tooling asg instances"
}

variable "capacity_tooling-asg" {
  type        = number
  description = "defines the desired capacity for tooling asg instances"
}

variable "health_grace_period_tooling-asg" {
  type        = number
  description = "defines the health_check_grace_period for tooling asg instances"
}




