resource "azurerm_storage_account" "example" {
  name                     = "ajirijamesstorage"   
  resource_group_name      = azurerm_resource_group.ajiri.name
  location                = azurerm_resource_group.canadacentral.location
  account_tier             = "Standard"
  account_replication_type = "LRS"   # Locally redundant storage
}
