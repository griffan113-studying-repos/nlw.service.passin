resource "azurerm_virtual_network" "vnet" {
  name                = "passin-vnet-${terraform.workspace}"
  location            = var.location
  resource_group_name = var.resourceGroupName
  address_space       = ["10.0.0.0/16"]

  tags = {
    "iac" = true
  }
}

resource "azurerm_subnet" "db_subnet" {
  name                 = "passin-db-subnet"
  resource_group_name  = var.resourceGroupName
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]

  private_link_service_network_policies_enabled = true
}

resource "azurerm_subnet" "container_subnet" {
  name                 = "container-subnet"
  resource_group_name  = var.resourceGroupName
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]

  private_link_service_network_policies_enabled = true
}
