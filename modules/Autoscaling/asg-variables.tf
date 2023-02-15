variable "ami_base" {
  type        = string
  description = "AMI image_ids for the launch templates"
}

variable "ami_web" {
  type        = string
  description = "AMI image_ids for the launch templates"
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

variable "health_grace_period_asg" {
  description = "A mapping of the health_check_grace_period for asg instances."
  type        = map(string)
  default     = {}
}

variable "capacity_asg" {
  description = "A mapping of the desired capacity for asg instances."
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

variable "bastion-sg" {
  description = "bastion security group"
  type        = string
}

variable "nginx-sg" {
  description = "nginx security group"
  type        = string
}

variable "web-sg" {
  description = "webservers security group"
  type        = string
}

variable "instance_profile" {
  description = "IAM instance profile"
  type        = string
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

variable "nginx-alb-tgt" {
  type        = string
  description = "nginx reverse proxy target group"
}

variable "wordpress-alb-tgt" {
  type        = string
  description = "wordpress target group"
}

variable "tooling-alb-tgt" {
  type        = string
  description = "tooling target group"
}