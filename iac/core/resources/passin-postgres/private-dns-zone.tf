resource "azurerm_private_dns_zone" "private_dns" {
  name                = "passin-${terraform.workspace}.postgres.database.azure.com"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "private_dns_link" {
  name                  = "${var.vnet_name}.com"
  private_dns_zone_name = azurerm_private_dns_zone.private_dns.name
  virtual_network_id    = var.vnet_id
  resource_group_name   = var.resource_group_name

  depends_on = [azurerm_subnet.postgres_subnet]
}
