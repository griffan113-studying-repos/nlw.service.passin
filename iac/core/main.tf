module "vnet" {
  depends_on = [data.terraform_remote_state.foundation]
  source     = "./resources/passin-vnet"

  resource_group_name = data.terraform_remote_state.foundation.outputs.rg_name
  location            = data.terraform_remote_state.foundation.outputs.rg_location
}

module "postgres" {
  depends_on = [module.vnet]
  source     = "./resources/passin-postgres"

  resource_group_name = data.terraform_remote_state.foundation.outputs.rg_name
  location            = data.terraform_remote_state.foundation.outputs.rg_location
  postgres_login      = var.postgres_login
  postgres_password   = var.postgres_password
  vnet_id             = module.vnet.vnet_id
  vnet_name           = module.vnet.vnet_name
}

module "api" {
  source = "./resources/passin-api"

  resource_group_name    = data.terraform_remote_state.foundation.outputs.rg_name
  location               = data.terraform_remote_state.foundation.outputs.rg_location
  postgres_host          = module.postgres.postgres_database_host
  postgres_database_name = module.postgres.postgres_database_name
  postgres_login         = var.postgres_login
  postgres_password      = var.postgres_password
  vnet_id                = module.vnet.vnet_id
  vnet_name              = module.vnet.vnet_name
}
