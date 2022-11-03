terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tfstates-iprd-ue"
    storage_account_name = "sremanuallymanaged"
    container_name       = "terraformstates"
    key                  = "azure-cloud-sandbox/terraform.tfstate"
  }
}
