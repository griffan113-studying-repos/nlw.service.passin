resource "azurerm_subnet" "postgres_subnet" {
  name                 = "passin-${terraform.workspace}-postgres-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_name
  address_prefixes     = ["10.0.1.0/24"]

  delegation {
    name = "postgres-delegation"

    service_delegation {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
        "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
      ]
    }
  }

  // Se for APENAS delegar para o Flexible Server, não precisa
  // mexer em private_endpoint_network_policies. Deixe no default.
  // private_endpoint_network_policies = "Disabled" 
}
