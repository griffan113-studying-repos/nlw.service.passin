output "db_subnet_id" {
  value = azurerm_subnet.db_subnet.id
}

output "container_subnet_id" {
  value = azurerm_subnet.container_subnet.id
}
