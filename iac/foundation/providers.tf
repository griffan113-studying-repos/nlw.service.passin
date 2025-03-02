terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.19.0"
    }
  }

  backend "azurerm" {
    storage_account_name = "passintfstateaccount"
    container_name       = "tfstate"
    key                  = "foundation.tfstate"
    resource_group_name  = "passin-tfstate"
  }
}

provider "azurerm" {
  features {}
}
