variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

variable "availability_zone" {
  description = "Availability Zone for subnets"
  type        = string
  default     = "us-west-2a"
}

variable "aws_profile" {
  description = "AWS profile used"
  type        = string
  default     = "csacct"
}

variable "vpc_cidr_block" {
  description = "CIDR block for VPC"
  type        = string
  default     = "192.168.0.0/16"
}

variable "public_subnet" {
  description = "Public Subnet"
  type        = string
  default     = "192.168.0.0/24"
}

variable "private_subnet" {
  description = "Private Subnet"
  type        = string
  default     = "192.168.1.0/24"
}