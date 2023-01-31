
# V-NET
resource "azurerm_virtual_network" "example" {
  name                = "example-network"
  address_space       = ["10.0.0.0/16"]
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
}

# Subnet
resource "azurerm_subnet" "example" {
  name                 = "internal"
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.2.0/24"]
}

# # Public IP
# resource "azurerm_public_ip" "public_ip" {
#   name                = "vm_public_ip"
#   resource_group_name = data.azurerm_resource_group.rg.name
#   location            = data.azurerm_resource_group.rg.location
#   allocation_method   = "Dynamic"
# }

# Network Interface (NIC)
resource "azurerm_network_interface" "example" {
  name                = "example-nic"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
    # public_ip_address_id          = azurerm_public_ip.public_ip.id
  }
}

# # Network Security Group (NSG)
# # Allow SSH Connection
# resource "azurerm_network_security_group" "nsg" {
#   name                = "ssh_nsg"
#   location            = data.azurerm_resource_group.rg.location
#   resource_group_name = data.azurerm_resource_group.rg.name

#   security_rule {
#     name                       = "allow_ssh_sg"
#     priority                   = 100
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "Tcp"
#     source_port_range          = "*"
#     destination_port_range     = "22"
#     source_address_prefix      = "*"
#     destination_address_prefix = "*"
#   }
# }

# # Associate NSG with NIC
# resource "azurerm_network_interface_security_group_association" "association" {
#   network_interface_id      = azurerm_network_interface.example.id
#   network_security_group_id = azurerm_network_security_group.nsg.id
# }

resource "random_password" "vm_password" {
  length  = 16
  special = true
}

resource "azurerm_linux_virtual_machine" "example" {
  name                = "example-machine"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  admin_password      = random_password.vm_password.result

  network_interface_ids = [
    azurerm_network_interface.example.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }


  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
