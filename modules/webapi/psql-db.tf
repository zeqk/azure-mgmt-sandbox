# resource "azurerm_postgresql_flexible_server_database" "webapi" {
#   name      = "psqldb-wasute-${var.env.abbreviation}-${var.location.abbreviation}"
#   server_id = azurerm_postgresql_flexible_server.webapi01.id
#   collation = "en_US.utf8"
#   charset   = "utf8"
# }

# # SELECT * FROM pg_available_extensions order by name;
# # CREATE EXTENSION IF NOT EXISTS tablefunc
# # CREATE EXTENSION IF NOT EXISTS unaccent
# # CREATE EXTENSION IF NOT EXISTS uuid-ossp

# resource "azurerm_postgresql_flexible_server_configuration" "webapi01" {
#   name      = "azure.extensions"
#   server_id = azurerm_postgresql_flexible_server.webapi01.id
#   value     = "TABLEFUNC,UNACCENT,UUID-OSSP,CITEXT,DBLINK"
# }

# resource "postgresql_extension" "tablefunc" {
#   name = "tablefunc"
# }

# resource "postgresql_extension" "unaccent" {
#   name = "unaccent"
# }

# resource "postgresql_extension" "uuidossp" {
#   name = "uuid-ossp"
# }

# resource "postgresql_extension" "citext" {
#   name = "citext"
# }

# resource "postgresql_extension" "dblink" {
#   name = "dblink"
# }
