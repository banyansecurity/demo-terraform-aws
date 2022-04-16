module "aws_connector" {
  source                 = "banyansecurity/banyan-connector/aws"
  name_prefix            = var.name_prefix
  region                 = var.region  
  vpc_id                 = var.vpc_id
  subnet_id              = var.subnet_id
  ssh_key_name           = var.ssh_key_name
  banyan_host            = var.banyan_host
  banyan_api_key         = var.banyan_api_key
  connector_name         = var.connector_name
}
