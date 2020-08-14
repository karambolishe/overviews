resource "azurerm_application_insights" "app_insights" {
  name                = "app-insights-overviews-${var.environment}"
  location            = azurerm_resource_group.common.location
  resource_group_name = azurerm_resource_group.common.name
  application_type    = "web"
}

resource "azurerm_key_vault_secret" "kv_instrumental_key" {
  name         = "appInsighthKey"
  value        = azurerm_application_insights.app_insights.instrumentation_key
  key_vault_id = azurerm_key_vault.kv.id
  depends_on = [
    azurerm_key_vault_access_policy.kv_access_policy
  ]
}

resource "azurerm_key_vault_secret" "kv_instrumental_app_id" {
  name         = "appInsighthAppId"
  value        = azurerm_application_insights.app_insights.app_id
  key_vault_id = azurerm_key_vault.kv.id
  depends_on = [
    azurerm_key_vault_access_policy.kv_access_policy
  ]
}

output "instrumentation_key" {
  value = azurerm_application_insights.app_insights.instrumentation_key
  sensitive = true
}

output "app_id" {
  value = azurerm_application_insights.app_insights.app_id
  sensitive = true
}
