terraform {
  required_providers {
    banyan = {
      source  = "banyansecurity/banyan"
      version = "0.6.1"
    }
  }
}

provider "banyan" {
  api_token   = var.banyan_api_key
  host        = var.banyan_host
}


resource "banyan_service_web" "web" {
  name           = "${var.name_prefix}-web"
  connector      = var.connector_name
  domain         = "${var.name_prefix}-web.${var.banyan_org}.banyanops.com"
  backend_domain = var.application_address
  backend_port   = 80
  backend_tls    = false
}

resource "banyan_service_infra_ssh" "ssh" {
  name           = "${var.name_prefix}-ssh"
  connector      = var.connector_name
  domain         = "${var.name_prefix}-web.${var.banyan_org}.banyanops.com"
  backend_domain = var.application_address
  backend_port   = 22
}

resource "banyan_service_infra_db" "db" {
  name           = "${var.name_prefix}-db"
  connector      = var.connector_name
  domain         = "${var.name_prefix}-web.${var.banyan_org}.banyanops.com"
  backend_domain = var.database_address
  backend_port   = var.database_port
}