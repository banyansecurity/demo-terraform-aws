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

variable "cidr_vpc" {
  description = "CIDR block for VPC"
  type        = string
  default     = "192.168.0.0/16"
}

variable "cidr_public_subnet" {
  description = "CIDR block for public subnet"
  type        = string
  default     = "192.168.0.0/24"
}

variable "cidr_private_subnet" {
  description = "CIDR block for private subnet"
  type        = string
  default     = "192.168.1.0/24"
}
