data "azuread_group" "sre" {
  display_name = "SRE"
}

data "azurerm_client_config" "current" {
}

data "azurerm_resource_group" "rg" {
  name = var.rgName
}
