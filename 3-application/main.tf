terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
}

provider "aws" {
  region  = var.region
  profile = var.profile
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

locals {
  init_script = <<INIT_SCRIPT
#!/bin/bash
sudo apt update -y
sudo apt install -y ca-certificates curl gnupg lsb-release
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
sudo echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update -y
sudo apt install -y docker-ce docker-ce-cli containerd.io
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
export INSTANCE_ID="${var.name_prefix}"
export PRIVATE_IP="$(hostname -i | awk '{print $1}')"
docker run -e INSTANCE_ID=$INSTANCE_ID -e PRIVATE_IP=$PRIVATE_IP -p 80:80 gcr.io/banyan-pub/demo-site
sleep 10
INIT_SCRIPT
}

resource "aws_instance" "_" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"  
  key_name      = var.ssh_key_name
  subnet_id     = var.subnet_id
  vpc_security_group_ids  = [var.security_group_id]
  associate_public_ip_address = false

  tags = {
    Name = "${var.name_prefix}-app"
  }

  user_data = local.init_script
}
