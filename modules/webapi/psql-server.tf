# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_database

# resource "random_password" "password" {
#   length  = 16
#   special = true
# }

# resource "azurerm_postgresql_flexible_server" "webapi01" {
#   name                   = "psql-wa01-${var.env.abbreviation}-${var.location.abbreviation}"
#   resource_group_name    = data.azurerm_resource_group.rg.name
#   location               = data.azurerm_resource_group.rg.location
#   administrator_login    = "dbadmin"
#   administrator_password = random_password.password.result
#   version                = "14"
#   storage_mb             = 32768
#   sku_name               = "B_Standard_B1ms"
#   zone                   = "1"
#   tags = {
#     Environment = var.env.name
#   }
# }