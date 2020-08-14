resource "azurerm_app_service_plan" "service-plan" {
  name = "app-overviews-plan-${var.environment}"
  location = azurerm_resource_group.common.location
  resource_group_name = azurerm_resource_group.common.name
  kind = "Linux"
  reserved = true
  sku {
    tier = var.kv_sku_name
    size = "S1"
  }
  tags = {
    environment = var.environment
  }
}

resource "azurerm_app_service" "app-service" {
  name = "app-overviews-${var.environment}"
  location = azurerm_resource_group.common.location
  resource_group_name = azurerm_resource_group.common.name
  app_service_plan_id = azurerm_app_service_plan.service-plan.id
  site_config {
    linux_fx_version = "DOTNETCORE|3.1"
  }
  tags = {
    environment = var.environment
  }
}

resource "azurerm_storage_account" "st-account-app-service" {
  name                     = "${var.project}${var.environment}"
  resource_group_name      = azurerm_resource_group.common.name
  location                 = azurerm_resource_group.common.location
  account_kind             = "StorageV2"
  account_tier             = "Standard"
  account_replication_type = "GRS"
  allow_blob_public_access = false

  network_rules {
    default_action             = "Deny"
    ip_rules                   = var.ip_rules
  }

  tags = {
    environment = var.environment
  }
}
