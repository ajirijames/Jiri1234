resource "azurerm_app_service_plan" "app2025" {
  name                = "appsp2025"
  location            = azurerm_resource_group.canadacentral.location
  resource_group_name = azurerm_resource_group.mcit_resource_group_ajiri.name
  kind                = "FunctionApp"  
  sku {
    tier = "Free"  
    size = "F1"     
  }
}

resource "azurerm_function_app" "functionapp2025" {
  name                       = "ajirifunctionapp"  # Function App name must be globally unique
  location                   = azurerm_resource_group.canadacentral.location
  resource_group_name        = azurerm_resource_group.mcit_resource_group_ajiri.name
  app_service_plan_id        = azurerm_app_service_plan.appsp2025.id
  storage_account_name      = azurerm_storage_account.example.name
  storage_account_access_key = azurerm_storage_account.example.primary_access_key
  os_type                    = "Linux"  
