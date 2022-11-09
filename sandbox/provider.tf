terraform {

  required_version = ">=1.2.4"
  
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~> 3.30.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.26.1"
    }
    random = {
      source = "hashicorp/random"
      version = "3.4.3"
    }

    postgresql = {
      source = "cyrilgdn/postgresql"
      version = "1.17.1"
    }
  }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
  subscription_id      = var.subscription_id
  tenant_id            = var.tenant_id
}

provider "azuread" {
  tenant_id = var.tenant_id  
}

provider "random" {
  
}
