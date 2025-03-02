resource "azurerm_postgresql_flexible_server" "postgres_server" {
  name                = "passin-${terraform.workspace}-postgresql-server"
  location            = var.location
  resource_group_name = var.resource_group_name

  sku_name = "B_Standard_B1ms"

  storage_tier                 = "P4"
  storage_mb                   = 32768
  backup_retention_days        = 7
  geo_redundant_backup_enabled = false
  auto_grow_enabled            = false

  administrator_login    = var.postgres_login
  administrator_password = var.postgres_password
  version                = "16"

  delegated_subnet_id = azurerm_subnet.postgres_subnet.id
  private_dns_zone_id = azurerm_private_dns_zone.private_dns.id

  public_network_access_enabled = false

  zone = "1"

  tags = {
    "iac" = true
  }

  depends_on = [azurerm_subnet.postgres_subnet, azurerm_private_dns_zone_virtual_network_link.private_dns_link]
}

resource "azurerm_postgresql_flexible_server_database" "postgres_database" {
  name      = "passin-database"
  server_id = azurerm_postgresql_flexible_server.postgres_server.id

  # Prevent the possibility of accidental data loss
  # lifecycle {
  #   prevent_destroy = true
  # }

  depends_on = [azurerm_postgresql_flexible_server.postgres_server]
}
