locals {
  env_abbreviation = "sbx"
  env_name         = basename(abspath(path.module))
  rgName           = "rg-sandbox"
}

module "citools" {
  source = "../modules/ci-tools"
  location = {
    abbreviation = "ue"
    name         = "eastus"
  }
  env = {
    abbreviation = local.env_abbreviation
    name         = local.env_name
  }
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
  rgName          = local.rgName
}

module "webapi" {
  source = "../modules/webapi"
  location = {
    abbreviation = "ue"
    name         = "eastus"
  }
  env = {
    abbreviation = local.env_abbreviation
    name         = local.env_name
  }
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
  rgName          = local.rgName
}

module "vmexample" {
  source = "../modules/vm-example"
  # location = {
  #   abbreviation = "ue"
  #   name         = "eastus"
  # }
  # env = {
  #   abbreviation = local.env_abbreviation
  #   name         = local.env_name
  # }
  # subscription_id = var.subscription_id
  # tenant_id       = var.tenant_id
  rgName          = local.rgName
}
