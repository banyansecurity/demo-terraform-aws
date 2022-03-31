terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

module "network" {
  source = "../1-network"
}

provider "aws" {
  region  = "${module.network.region}"
  profile  = "${module.network.profile}"

}

module "aws_connector" {
  source                 = "../../terraform-aws-banyan-connector"
  vpc_id                 = "${module.network.vpc_id}"
  subnet_id              = "${module.network.private_subnet}"
  ssh_key_name           = var.ssh_key
  api_key_secret         = var.api_key_secret
  connector_name         = var.connector_name
}
