resource "azurerm_postgresql_flexible_server" "postgres_server" {
  name                = "passin-postgresql-server-${terraform.workspace}"
  location            = var.location
  resource_group_name = var.resourceGroupName

  sku_name = "B_Standard_B1ms"

  storage_tier                 = "P4"
  storage_mb                   = 32768
  backup_retention_days        = 7
  geo_redundant_backup_enabled = false
  auto_grow_enabled            = false

  administrator_login    = var.postgresLogin
  administrator_password = var.postgresPassword
  version                = "16"

  public_network_access_enabled = false

  tags = {
    "iac" = true
  }
}

resource "azurerm_postgresql_flexible_server_database" "postgres_database" {
  name      = "passin"
  server_id = azurerm_postgresql_flexible_server.postgres_server.id

  # prevent the possibility of accidental data loss
  # lifecycle {
  #   prevent_destroy = true
  # }
}

resource "azurerm_private_endpoint" "postgres_private_endpoint" {
  name                = "postgres-private-endpoint"
  location            = var.location
  resource_group_name = var.resourceGroupName
  subnet_id           = var.subnetId

  private_service_connection {
    name                           = "postgres-private-connection"
    private_connection_resource_id = azurerm_postgresql_flexible_server.postgres_server.id
    subresource_names              = ["postgresqlServer"]
    is_manual_connection           = false
  }

  tags = {
    "iac" = true
  }
}
