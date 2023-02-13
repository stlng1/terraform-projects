variable "ami" {
  type        = map
  description = "AMI image_ids for the launch templates"
  default = {}
}

variable "project_phase_name" {
  type        = string
  description = "the name-tag of the project phase - dev, stage, prod"
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

variable "max_size_btn" {
  description = "A mapping of the max_size for bastion asg instances."
  type        = string
}

variable "min_size_btn" {
  description = "A mapping of the min_size for bastion asg instances."
  type        = string
}

variable "max_size_ngx" {
  description = "A mapping of the max_size for nginx asg instances."
  type        = string
}

variable "min_size_ngx" {
  description = "A mapping of the min_size for nginx asg instances."
  type        = string
}

variable "max_size_wps" {
  description = "A mapping of the max_size for wordpress asg instances."
  type        = string
}

variable "min_size_wps" {
  description = "A mapping of the min_size for wordpress asg instances."
  type        = string
}

variable "max_size_tlg" {
  description = "A mapping of the max_size for tooling asg instances."
  type        = string
}

variable "min_size_tlg" {
  description = "A mapping of the min_size for tooling asg instances."
  type        = string
}

variable "instance_type-btn" {
  description = "the processing capacity of a bastion instance."
  type        = string
}

variable "instance_type-ngx" {
  description = "the processing capacity of an nginx instance."
  type        = string
}

variable "instance_type-wps" {
  description = "the processing capacity of a wordpress instance."
  type        = string
}

variable "instance_type-tlg" {
  description = "the processing capacity of a tooling instance."
  type        = string
}