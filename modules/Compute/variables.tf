# variable "subnets-compute" {
#     description = "public subnets for compute instances"
# }

variable "ami" {
  type        = map
  description = "AMI image_ids for the launch templates"
  default = {}
}

# variable "ami-jenkins" {
#     type = string
#     description = "ami for jenkins"
# }

# variable "ami-jfrog" {
#     type = string
#     description = "ami for jfrob"
# }

variable "project_name" {
    type = string
    description = "name of the project"
}

variable "sg-compute" {
    description = "security group for compute instances"
    type = string
    default = "ACS-sg"
}

variable "keypair" {
    type = string
    description = "keypair for instances"
}

variable "tags" {
  description = "A mapping of tags to assign to all resources."
  type        = map(string)
  default     = {}
}

variable "public_subnets" {
  description = "list of public subnets."
  type = list(any)
}
