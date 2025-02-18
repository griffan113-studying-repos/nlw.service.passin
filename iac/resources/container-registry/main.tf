resource "azurerm_container_registry" "acr" {
  name                = "passin${terraform.workspace}"
  resource_group_name = var.resourceGroupName
  location            = var.location
  sku                 = "Basic"
  admin_enabled       = true
  tags = {
    "iac" = true
  }
}
