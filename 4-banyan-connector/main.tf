provider "aws" {
  region  = "us-east-1"
}

module "aws_connector" {
  source                 = "../../terraform-aws-banyan-connector"
  vpc_id                 = "vpc-123"
  subnet_id              = "subnet-123"
  ssh_key_name           = "my-key"
  api_key_secret         = "abc123..."
  connector_name         = "my-banyan-connector"
}
