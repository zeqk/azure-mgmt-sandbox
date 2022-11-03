resource "azurerm_kubernetes_cluster" "ci_tools" {
  name                = "aks-citools-${var.env.abbreviation}-${var.location.abbreviation}"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  dns_prefix          = "akscitools"
  network_profile {
    network_plugin = "kubenet"
    load_balancer_sku = "basic"
  }

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_B2s"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = var.env.name
  }
}