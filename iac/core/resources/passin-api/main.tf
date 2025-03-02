#########################
# App Service Plan
#########################
resource "azurerm_service_plan" "asp" {
  name                = "passin-${terraform.workspace}-appservice-plan"
  location            = var.location
  resource_group_name = var.resource_group_name

  os_type  = "Linux"
  sku_name = "P1v2"

  tags = {
    "iac" = true
  }
}

resource "random_password" "jwt_secret" {
  length  = 16
  special = false
}

#########################
# App Service (Docker)
#########################
resource "azurerm_linux_web_app" "api" {
  name                = "passin-${terraform.workspace}-api"
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = azurerm_service_plan.asp.id

  site_config {
  }

  # Regional VNet Integration
  virtual_network_subnet_id = azurerm_subnet.api_subnet.id

  app_settings = {
    "PORT"         = "80"
    "NODE_ENV"     = "production"
    "DATABASE_URL" = "postgres://${var.postgres_login}:${var.postgres_password}@${var.postgres_host}:5432/${var.postgres_database_name}?sslmode=require"
    "API_BASE_URL" = "http://localhost:80"
  }

  tags = {
    "iac" = true
  }
}
