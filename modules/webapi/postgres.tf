# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_database

resource "random_password" "password" {
  length  = 16
  special = true
}

resource "azurerm_postgresql_flexible_server" "webapi01" {
  name                   = "psql-wa01-${var.env.abbreviation}-${var.location.abbreviation}"
  resource_group_name    = data.azurerm_resource_group.rg.name
  location               = data.azurerm_resource_group.rg.location
  administrator_login    = "postgres"
  administrator_password = random_password.password.result
  version                = "14"
  storage_mb             = 32768
  sku_name               = "B_Standard_B1ms"
  zone                   = "1"
  tags = {
    Environment = var.env.name
  }
}

resource "azurerm_postgresql_flexible_server_database" "webapi" {
  name      = "psqldb-wasute-${var.env.abbreviation}-${var.location.abbreviation}"
  server_id = azurerm_postgresql_flexible_server.webapi01.id
  collation = "en_US.utf8"
  charset   = "utf8"
}

resource "azurerm_postgresql_flexible_server_configuration" "webapi01" {
  name      = "azure.extensions"
  server_id = azurerm_postgresql_flexible_server.webapi01.id
  value     = "TABLEFUNC,UNACCENT,UUID-OSSP"
}
