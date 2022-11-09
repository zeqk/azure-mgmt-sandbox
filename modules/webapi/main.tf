module "postgresql" {
  source = "./postgresql"
  server_host = azurerm_postgresql_flexible_server.webapi01.fqdn
  database    = azurerm_postgresql_flexible_server_database.webapi.name
  username    = azurerm_postgresql_flexible_server.webapi01.administrator_login
  password    = azurerm_postgresql_flexible_server.webapi01.administrator_password
}
