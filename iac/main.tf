terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.19.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "passin-tfstate"
    storage_account_name = "passinstorageacc"
    container_name       = "tfstate"
    key                  = "terraform-tfstate"
  }
}

provider "azurerm" {
  # Configuration options
  subscription_id = var.subscriptionId
  tenant_id       = var.tenantId
  client_id       = var.clientId     # app_id
  client_secret   = var.clientSecret # password

  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-passin-${terraform.workspace}"
  location = "eastus2"
  tags = {
    "iac" = true
  }
}

module "container-registry" {
  depends_on = [azurerm_resource_group.rg]
  source     = "./resources/container-registry"

  resourceGroupName = azurerm_resource_group.rg.name
  location          = azurerm_resource_group.rg.location
}

module "database" {
  depends_on = [azurerm_resource_group.rg]
  source     = "./resources/database"

  resourceGroupName = azurerm_resource_group.rg.name
  location          = azurerm_resource_group.rg.location
  postgresLogin     = var.postgresLogin
  postgresPassword  = var.postgresPassword
}

