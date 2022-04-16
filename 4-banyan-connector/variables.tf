variable "name_prefix" {
  type        = string
  description = "String to be added in front of all AWS object names"
}

variable "region" {
  type        = string
  description = "Region in AWS in which your VPC resides"
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC in which to create the Connector"
}

variable "subnet_id" {
  type        = string
  description = "ID of the subnet where the Connector instance should be created"
}

variable "ssh_key_name" {
  type        = string
  description = "Name of an SSH key stored in AWS to allow management access"
}

variable "banyan_host" {
  type        = string
  description = "URL of the Banyan Command Center"
  default     = "https://team.console.banyanops.com/"
}

variable "banyan_api_key" {
  type        = string
  description = "API Key or Refresh Token generated from the Banyan Command Center console"
}

variable "connector_name" {
  type        = string
  description = "connector_name"
}