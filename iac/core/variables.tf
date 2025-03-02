variable "postgres_login" {
  description = "Login do usuário administrador do PostgreSQL"
}

variable "postgres_password" {
  sensitive   = true
  description = "Senha do usuário administrador do PostgreSQL"
}
