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

resource "aws_instance" "devops_demo" {
  ami           = "ami-00ee4df451840fa9d"
  instance_type = "t2.micro"
  key_name = var.ssh_key
  subnet_id		= "${module.network.private_subnet}"
  vpc_security_group_ids	= "${module.network.private_network_security_group}"
  associate_public_ip_address = false
  
  tags = {
    Name = "workshop-appsrvr1"
  }
}
