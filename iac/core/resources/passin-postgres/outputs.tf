output "postgres_database_host" {
  description = "FQDN do Postgres"
  value       = azurerm_postgresql_flexible_server.postgres_server.fqdn
}

output "postgres_database_name" {
  description = "Nome do banco criado no Postgres"
  value       = azurerm_postgresql_flexible_server_database.postgres_database.name
}
