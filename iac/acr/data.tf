data "terraform_remote_state" "foundation" {
  backend = "azurerm"
  config = {
    storage_account_name = "passintfstateaccount"
    container_name       = "tfstate"
    resource_group_name  = "passin-tfstate"
    key                  = "foundation.tfstateenv:${terraform.workspace}"
  }
}
