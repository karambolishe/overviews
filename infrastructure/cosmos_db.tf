resource "azurerm_cosmosdb_account" "cosmos_db" {
  name                = "cosmos-${var.project}-${var.environment}"
  resource_group_name = azurerm_resource_group.common.name
  location            = azurerm_resource_group.common.location
  offer_type          = "Standard"

  consistency_policy {
    consistency_level = "Session"
  }

  geo_location {
    location          = azurerm_resource_group.common.location
    failover_priority = 0
  }

  tags = {
    environment = var.environment
  }
}

resource "azurerm_key_vault_secret" "cosmos_db_connection_string" {
  name         = "cosmosDBConnectionString"
  value        = "AccountEndpoint=${azurerm_cosmosdb_account.cosmos_db.endpoint};AccountKey=${azurerm_cosmosdb_account.cosmos_db.primary_master_key};"
  key_vault_id = azurerm_key_vault.kv.id

  depends_on = [
    azurerm_key_vault_access_policy.kv_access_policy,
  ]
}

resource "azurerm_cosmosdb_sql_database" "database" {
  name                = "research-platform"
  resource_group_name = azurerm_cosmosdb_account.cosmos_db.resource_group_name
  account_name        = azurerm_cosmosdb_account.cosmos_db.name
}

resource "azurerm_cosmosdb_sql_container" "container" {
  name                = "overviews"
  resource_group_name = azurerm_cosmosdb_sql_database.database.resource_group_name
  account_name        = azurerm_cosmosdb_sql_database.database.account_name
  database_name       = azurerm_cosmosdb_sql_database.database.name
}

output "cosmos_db_endpoint" {
  value = azurerm_cosmosdb_account.cosmos_db.endpoint
}

output "cosmos_db_primary_master_key" {
  value     = azurerm_cosmosdb_account.cosmos_db.primary_master_key
  sensitive = true
}

output "cosmos_db_primary_readonly_master_key" {
  value     = azurerm_cosmosdb_account.cosmos_db.primary_readonly_master_key
  sensitive = true
}

output "cosmos_db_connection_strings" {
  value     = azurerm_cosmosdb_account.cosmos_db.connection_strings
  sensitive = true
}

output "kv_secret_cosmos_db_connection_string_name" {
  value = azurerm_key_vault_secret.cosmos_db_connection_string.name
}
