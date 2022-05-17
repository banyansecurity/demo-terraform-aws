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

resource "banyan_role" "everyone" {
  name        = "${var.name_prefix}-everyone"
  description = "Any authenticated user"
  user_group  = ["AllUsers"]
}

resource "banyan_policy_web" "web_everyone_high" {
  name        = "${var.name_prefix}-web"
  description = "Allows web access to everyone with a high trust level"
  access {
    roles       = [banyan_role.everyone.name]
    trust_level = "High"
  }
}

resource "banyan_policy_infra" "infra_everyone_high" {
  name        = "${var.name_prefix}-infra"
  description = "Allows infra access to everyone with a high trust level"
  access {
    roles       = [banyan_role.everyone.name]
    trust_level = "High"
  }
}