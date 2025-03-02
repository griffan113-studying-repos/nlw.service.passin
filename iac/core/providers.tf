terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.19.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.7.1"
    }
  }

  backend "azurerm" {
    storage_account_name = "passintfstateaccount"
    container_name       = "tfstate"
    key                  = "core.tfstate"
    resource_group_name  = "passin-tfstate"
  }
}

provider "azurerm" {
  features {}
}

provider "random" {}
