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
  name        = "test_role"
  description = "all users"
  user_group  = ["Everyone"]
}

resource "banyan_policy" "web-anyone-high" {
  name        = "web-policy"
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

resource "banyan_policy" "infra-anyone-high" {
  name        = "infrastructure-policy"
  description = "some infrastructure policy description"
  access {
    roles       = ["AllUsers"]
    trust_level = "High"
  }
  disable_tls_client_authentication = false
}