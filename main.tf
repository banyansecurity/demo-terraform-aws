locals {
  connector_name = "${local.name_prefix}-conn"
}

module "network" {
  source = "./1-network"
  name_prefix = local.name_prefix
  region = local.region
  profile = local.profile
}

module "database" {
  source = "./2-database"
  name_prefix = local.name_prefix
  region = local.region
  profile = local.profile
  subnet_id = module.network.private_subnet_id
  subnet_2_id = module.network.private_2_subnet_id
  security_group_id = module.network.vpc_security_group_id
}

module "application" {
  source = "./3-application"
  name_prefix = local.name_prefix  
  region = local.region
  profile = local.profile  
  subnet_id = module.network.private_subnet_id
  security_group_id = module.network.vpc_security_group_id
  ssh_key_name = local.ssh_key_name
}

module "banyan-connector" {
  source = "./4-banyan-connector"
  name_prefix = local.name_prefix  
  region = local.region
  profile = local.profile  
  vpc_id = module.network.vpc_id  
  subnet_id = module.network.private_subnet_id
  ssh_key_name = local.ssh_key_name
  banyan_host = local.banyan_host
  banyan_api_key = local.banyan_api_key
  connector_name = local.connector_name
}

module "banyan-policies" {
  source = "./5-banyan-policies"
  name_prefix = local.name_prefix  
  banyan_host = local.banyan_host
  banyan_api_key = local.banyan_api_key
}

module "banyan-services" {
  source = "./6-banyan-services"
  name_prefix = local.name_prefix  
  banyan_host = local.banyan_host
  banyan_api_key = local.banyan_api_key
  banyan_org = local.banyan_org
  connector_name = local.connector_name
  web_policy_id = module.banyan-policies.web_policy_id
  infra_policy_id = module.banyan-policies.infra_policy_id
  database_address = module.database.address
  database_port = module.database.port
  application_address = module.application.address
}
