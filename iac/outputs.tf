output "acr_login_server" {
  value = module.container-registry.acr_login_server
}

output "acr_username" {
  value = module.container-registry.acr_username
}

output "acr_password" {
  value     = module.container-registry.acr_password
  sensitive = true
}
