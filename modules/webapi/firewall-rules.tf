# https://github.com/hashicorp/terraform-provider-azurerm/issues/14989

resource "azurerm_postgresql_flexible_server_firewall_rule" "azure" {
  name             = "allow-access-from-azure-services"
  server_id        = azurerm_postgresql_flexible_server.webapi01.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}

# resource "azurerm_postgresql_flexible_server_firewall_rule" "all" {
#   name             = "allow-all-ips"
#   server_id        = azurerm_postgresql_flexible_server.webapi01.id
#   start_ip_address = "0.0.0.0"
#   end_ip_address   = "255.255.255.255"
# }