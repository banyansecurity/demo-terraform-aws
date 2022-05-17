terraform {
  required_providers {
    banyan = {
      source  = "banyansecurity/banyan"
      version = "0.6.3"
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

resource "banyan_policy_attachment" "web" {
  attached_to_id   = banyan_service_web.web.id
  policy_id        = var.web_policy_id
  attached_to_type = "service"
  is_enforcing     = true
}

resource "banyan_service_infra_ssh" "ssh" {
  name           = "${var.name_prefix}-ssh"
  connector      = var.connector_name
  domain         = "${var.name_prefix}-ssh.${var.banyan_org}.banyanops.com"
  backend_domain = var.application_address
  backend_port   = 22
}

resource "banyan_policy_attachment" "ssh" {
  attached_to_id   = banyan_service_infra_ssh.ssh.id
  policy_id        = var.infra_policy_id
  attached_to_type = "service"
  is_enforcing     = true
}

resource "banyan_service_infra_db" "db" {
  name           = "${var.name_prefix}-db"
  connector      = var.connector_name
  domain         = "${var.name_prefix}-db.${var.banyan_org}.banyanops.com"
  backend_domain = var.database_address
  backend_port   = var.database_port
  client_banyanproxy_listen_port = 8811
}

resource "banyan_policy_attachment" "db" {
  attached_to_id   = banyan_service_infra_db.db.id
  policy_id        = var.infra_policy_id
  attached_to_type = "service"
  is_enforcing     = true  
}
