resource "azurerm_key_vault_secret" "ConnectionStringsDefaultInAzure" {
  name         = "ConnectionStrings--DefaultInAzure"
  value        = "Server=${azurerm_postgresql_flexible_server.webapi01.fqdn};Database=${azurerm_postgresql_flexible_server_database.webapi.name};Port=5432;User Id=${azurerm_postgresql_flexible_server.webapi01.administrator_login};Password=${azurerm_postgresql_flexible_server.webapi01.administrator_password};Ssl Mode=Require;"
  key_vault_id = data.azurerm_key_vault.wasute.id
}