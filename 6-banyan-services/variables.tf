variable "name_prefix" {
  type        = string
  description = "String to be added in front of all Banyan object names"
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

variable "banyan_org" {
  type        = string
  description = "Org Name in Banyan"
}

variable "connector_name" {
  type        = string
  description = "Name of the Connector"
}

variable "web_policy_id" {
  type        = string
  description = "ID of Banyan web policy"
}

variable "infra_policy_id" {
  type        = string
  description = "ID of Banyan infra policy"
}

variable "database_address" {
  type        = string
  description = "IP address of database"
}

variable "database_port" {
  type        = number
  description = "Port of database"
}

variable "application_address" {
  type        = string
  description = "IP address of application"
}