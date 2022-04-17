variable "name_prefix" {
  description = "String to be added in front of all AWS object names"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

variable "profile" {
  description = "AWS profile"
  type        = string
  default     = "default"
}

variable "subnet_id" {
  description = "Subnet ID"
  type        = string
}

variable "subnet_2_id" {
  description = "Subnet ID"
  type        = string
}

variable "security_group_id" {
  description = "Security Group"
  type        = string
}
