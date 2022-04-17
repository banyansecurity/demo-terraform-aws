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


resource "aws_db_subnet_group" "_" {
  name       = "${var.name_prefix}-db_subnet_group"
  subnet_ids = [var.subnet_id, var.subnet_2_id]
}

resource "aws_db_instance" "_" {
  identifier                = "${var.name_prefix}-db"
  db_subnet_group_name      = aws_db_subnet_group._.id
  vpc_security_group_ids    = [var.security_group_id]

  allocated_storage    = 5
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  name                 = "mydb"
  username             = "foo"
  password             = "foobarbaz"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true

  tags = {
    Name = "${var.name_prefix}-db"
  }  
}


