variable "project_phase_name" {
  type        = string
  description = "the name-tag of the project phase - dev, stage, prod"
}

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

# variable "ami" {
#   type        = map
#   description = "AMI image_ids for the launch templates"
#   default = {}
# }

variable "db_name" {
  type        = string
  description = "the name of the database"
}

# variable "data_private_subnets-1" {
#   type = string
#   description = "First subnet for the mount target"
# }

# variable "data_private_subnets-2" {
#   type = string
#   description = "Second subnet for the mount target"
# }

# variable "ami" {
#   type        = map(any)
#   description = "AMI image_ids for the launch templates"
#   default     = {}
# }

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

variable "domain_subnet_1" {
  type        = string
  description = "list of domain subnets"
}

variable "domain_subnet_2" {
  type        = string
  description = "list of domain subnets"
}

# variable "my_s3_bucket" {
#   type        = string
#   description = "name of my aws s3 bucket"
# }

variable "name" {
  type    = string
  default = "ACS"

}

# variable "ami-jenkins" {
#     type = string
#     description = "ami for jenkins"
# }

# variable "ami-jfrog" {
#     type = string
#     description = "ami for jfrob"
# }

# variable "project_name" {
#   type        = string
#   description = "name of the project"
# }

# variable "sg-compute" {
#   description = "security group for compute instances"
#   type        = string
# }

# variable "keypair" {
#   type        = string
#   description = "keypair for instances"
# }

# variable "tags" {
#   description = "A mapping of tags to assign to all resources."
#   type        = map(string)
#   default     = {}
# }

# variable "public_subnets" {
#   description = "list of public subnets."
#   type        = list(any)
# }

# variable "account_no" {
#   type        = number
#   description = "the account number"
# }

# variable "tags" {
#   description = "A mapping of tags to assign to all resources"
#   type        = map(string)
#   default     = {}
# }

variable "user_arn" {
  type = string
}

variable "access_point" {
  type        = list(any)
  description = "efs access point"
}

# variable "tags" {
#   description = "A mapping of tags to assign to all resources"
#   type        = map(string)
#   default     = {}
# }

variable "master-username" {
  type        = string
  description = "RDS admin username"
}

variable "master-password" {
  type        = string
  description = "RDS master password"
}

# variable "datalayer-sg" {
#   type        = string
#   description = "datalayer security group"
# }

# variable "tags" {
#   description = "A mapping of tags to assign to all resources"
#   type        = map(string)
#   default     = {}
# }

# variable "vpc_id" {
#   type        = string
#   description = "the vpc id"
# }

# variable "region" {
#   type = string
# }

variable "vpc_cidr" {
  type = string
}

variable "enable_dns_support" {
  type = bool
}

variable "enable_dns_hostnames" {
  type = bool
}

# variable "enable_classiclink" {
#   type = bool
# }

# variable "enable_classiclink_dns_support" {
#   type = bool
# }

variable "public_subnets" {
  type = list(any)
}

variable "compute_private_subnets" {
  type = list(any)
}

variable "data_private_subnets" {
  type = list(any)
}

# variable "tags" {
#   description = "A mapping of tags to assign to all resources"
#   type        = map(string)
#   default     = {}
# }

# variable "preferred_number_of_public_subnets" {
#   type = number
# }

# variable "preferred_number_of_private_subnets" {
#   type = number
# }

# variable "name" {
#   type    = string
#   default = "ACS"

# }
# variable "environment" {
#   default = "true"
# }

variable "ami_base" {
  type        = string
  description = "AMI image_ids for the launch templates"
}

variable "ami_web" {
  type        = string
  description = "AMI image_ids for the launch templates"
}