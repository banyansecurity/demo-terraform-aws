terraform {
  required_providers {
    banyan = {
      source  = "github.com/banyansecurity/banyan"
      version = "0.5.0"
    }
  }
}

provider "banyan" {
  api_token   = var.banyan_api_token
  host        = var.banyan_host
}

resource "banyan_role" "test_role" {
  name        = "test_role"
  description = "all users"
  user_group  = ["Everyone"]
}