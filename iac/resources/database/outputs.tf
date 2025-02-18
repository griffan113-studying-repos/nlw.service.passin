output "postgres_database_host" {
  value = azurerm_postgresql_flexible_server.postgres_server.fqdn
}
