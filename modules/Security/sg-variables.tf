variable "tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
  default     = {}
}

variable "vpc_id" {
  type        = string
  description = "the vpc id"
}

variable "project_name" {
  type = string
}
