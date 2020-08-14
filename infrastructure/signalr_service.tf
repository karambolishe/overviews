resource "azurerm_signalr_service" "signal_r_service" {
  name                = "signalr-overviews-${var.environment}"
  location            = azurerm_resource_group.common.location
  resource_group_name = azurerm_resource_group.common.name

  sku {
    name     = "Free_F1"
    capacity = 1
  }

  cors {
    allowed_origins = ["http://www.example.com"]
  }

  features {
    flag  = "ServiceMode"
    value = "Default"
  }
}

resource "azurerm_key_vault_secret" "signalr_service_hostname" {
  name         = "signalRServiceHostname"
  value        = azurerm_signalr_service.signal_r_service.hostname
  key_vault_id = azurerm_key_vault.kv.id

  depends_on = [
    azurerm_key_vault_access_policy.kv_access_policy,
  ]
}

resource "azurerm_key_vault_secret" "signalr_service_access_key" {
  name         = "signalRServiceAccessKey"
  value        = azurerm_signalr_service.signal_r_service.primary_access_key
  key_vault_id = azurerm_key_vault.kv.id

  depends_on = [
    azurerm_key_vault_access_policy.kv_access_policy,
  ]
}

output "signalr_service_hostname" {
  value = azurerm_signalr_service.signal_r_service.hostname
}