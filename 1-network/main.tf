terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile

}

# Creating a VPC
resource "aws_vpc" "workshop_vpc" {
  
  # IP Range for the VPC
  cidr_block = var.vpc_cidr_block
  
  # Enabling automatic hostname assigning
  enable_dns_hostnames = true
  tags = {
    Name = "workshop_vpc"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.workshop_vpc.id
  cidr_block        = var.public_subnet
  availability_zone = var.availability_zone

  tags = {
    Name = "Workshop - Public Subnet"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.workshop_vpc.id
  cidr_block        = var.private_subnet
  availability_zone = var.availability_zone

  tags = {
    Name = "Workshop - Private Subnet"
  }
}

resource "aws_internet_gateway" "workshop_ig" {
  vpc_id = aws_vpc.workshop_vpc.id

  tags = {
    Name = "Some Internet Gateway"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.workshop_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.workshop_ig.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.workshop_ig.id
  }

  tags = {
    Name = "Public Route Table"
  }
}

resource "aws_eip" "elastic_ip" {
  vpc      = true
}

resource "aws_nat_gateway" "workshop_nat_gateway" {
  allocation_id = aws_eip.elastic_ip.id
  subnet_id     = aws_subnet.public_subnet.id

  tags = {
    Name = "workshop nat-gateway"
  }
}
  
resource "aws_route_table" "nat_rt" {
  vpc_id = aws_vpc.workshop_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.workshop_nat_gateway.id
  }

  tags = {
    Name = "NAT-route-table"
  }
}

resource "aws_route_table_association" "public_1_rt_a" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_1_rt_b" {
  subnet_id		 = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.nat_rt.id
}

resource "aws_security_group" "web_sg" {
  name   = "HTTP and SSH"
  vpc_id = aws_vpc.workshop_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "private_sg" {
  name   = "Workshop Private SG"
  vpc_id = aws_vpc.workshop_vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = [var.vpc_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}
