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

resource "banyan_role" "test_role" {
  name        = "${var.name_prefix}-everyone"
  description = "Everyone"
  user_group  = ["AllUsers"]
}

resource "banyan_policy" "web_everyone_high" {
  name        = "${var.name_prefix}-web"
  description = "Allows web access to everyone with a high trust level"
  access {
    roles       = ["AllUsers"]
    trust_level = "High"
    l7_access {
      resources = ["*"]
      actions   = ["*"]
    }
  }
  l7_protocol                       = "http"
  disable_tls_client_authentication = true
}

resource "banyan_policy" "infra_everyone_high" {
  name        = "${var.name_prefix}-infra"
  description = "Allows infra access to everyone with a high trust level"
  access {
    roles       = ["AllUsers"]
    trust_level = "High"
  }
  disable_tls_client_authentication = false
}