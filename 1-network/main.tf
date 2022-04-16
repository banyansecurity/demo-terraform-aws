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

resource "aws_vpc" "_" {
  cidr_block = var.cidr_vpc
  
  enable_dns_hostnames = true
  tags = {
    Name = "${var.name_prefix}-vpc"
  }
}

resource "aws_subnet" "public" {
  vpc_id            = aws_vpc._.id
  cidr_block        = var.cidr_public_subnet

  tags = {
    Name = "${var.name_prefix}-public_subnet"
  }
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc._.id
  cidr_block        = var.cidr_private_subnet

  tags = {
    Name = "${var.name_prefix}-private_subnet"
  }
}

resource "aws_internet_gateway" "_" {
  vpc_id = aws_vpc._.id

  tags = {
    Name = "${var.name_prefix}-internet_gateway"
  }
}

resource "aws_route_table" "ig" {
  vpc_id = aws_vpc._.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway._.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway._.id
  }

  tags = {
    Name = "${var.name_prefix}-route_table_ig"
  }
}

resource "aws_route_table_association" "ig" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.ig.id
}

resource "aws_eip" "nat" {
  vpc      = true
}

resource "aws_nat_gateway" "_" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public.id

  tags = {
    Name = "${var.name_prefix}-nat_gateway"
  }
}
  
resource "aws_route_table" "nat" {
  vpc_id = aws_vpc._.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway._.id
  }

  tags = {
    Name = "${var.name_prefix}-route_table_nat"
  }
}

resource "aws_route_table_association" "nat" {
  subnet_id		 = aws_subnet.private.id
  route_table_id = aws_route_table.nat.id
}

resource "aws_security_group" "vpc_sg" {
  name   = "${var.name_prefix}-vpc_sg"
  vpc_id = aws_vpc._.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = [var.cidr_vpc]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name_prefix}-vpc_sg"
  }  
}
