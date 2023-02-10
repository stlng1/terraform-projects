variable "ami" {
  type        = map
  description = "AMI image_ids for the launch templates"
  default = {}
}

# variable "ami-webservers" {
#   type        = string
#   description = "AMI image_id for the webservers (tooling and wordpress) launch templates"
# }

variable "keypair" {
  type        = string
  description = "key pair for the instances"
}

variable "tags" {
  description = "A mapping of tags to assign to all resources."
  type        = map(string)
  default     = {}
}

variable "max_size_asg" {
  description = "A mapping of he max_size for asg instances."
  type        = map(string)
  default     = {}
}

variable "min_size_asg" {
  description = "A mapping of he max_size for asg instances."
  type        = map(string)
  default     = {}
}

variable "capacity_asg" {
  description = "A mapping of the desired capacity for asg instances."
  type        = map(string)
  default     = {}
}

variable "health_grace_period_asg" {
  description = "A mapping of the health_check_grace_period for asg instances."
  type        = map(string)
  default     = {}
}





