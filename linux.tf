resource "azurerm_resource_group" "example" {
  name     = "mcit_resource_group_ajiri"
  location = "Canada Central"
}

resource "azurerm_virtual_network" "vnet2025" {
  name                = "ajiri-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.canadacentral.location
  resource_group_name = azurerm_resource_group.mcit_resource_group_ajiri.name
}

resource "azurerm_subnet" "subnet2025" {
  name                 = "ajirisubnet"
  resource_group_name  = azurerm_resource_group.mcit_resource_group_ajiri.name
  virtual_network_name = azurerm_virtual_network.ajiri-network.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "nic2025" {
  name                = "ajiri-nic"
  location            = azurerm_resource_group.canadacentral.location
  resource_group_name = azurerm_resource_group.mcit_resource_group_ajiri.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "linuxvm2025" {
  name                = "ajirilinuxvm"
  resource_group_name = azurerm_resource_group.mcit_resource_group_ajiri.name
  location            = azurerm_resource_group.canadacentral.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.example.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}
