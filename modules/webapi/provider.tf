terraform {
  required_providers {
    postgresql = {
      source = "cyrilgdn/postgresql"
    }

  }
}

# provider "postgresql" {
#   host            = azurerm_postgresql_flexible_server.webapi01.fqdn
#   port            = 5432
#   username        = azurerm_postgresql_flexible_server.webapi01.administrator_login
#   password        = azurerm_postgresql_flexible_server.webapi01.administrator_password
#   database        = azurerm_postgresql_flexible_server_database.webapi.name
#   sslmode         = "require"
#   connect_timeout = 180
#   superuser       = false
# }
