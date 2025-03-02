resource "azurerm_resource_group" "rg" {
  name     = "passin-${terraform.workspace}"
  location = "eastus"

  tags = {
    "iac" = true
  }
}

output "rg_name" {
  description = "Nome do Resource Group compartilhado"
  value       = azurerm_resource_group.rg.name
}

output "rg_location" {
  description = "Localização do RG"
  value       = azurerm_resource_group.rg.location
}
