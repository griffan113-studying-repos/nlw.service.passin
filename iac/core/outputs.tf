output "postgres_database_host" {
  description = "FQDN do Postgres"
  value       = module.postgres.postgres_database_host
}

output "postgres_database_name" {
  description = "Nome do banco criado no Postgres"
  value       = module.postgres.postgres_database_name
}

output "api_app_service_name" {
  value = module.api.api_app_service_name
}
