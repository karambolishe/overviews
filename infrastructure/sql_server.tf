resource "azurerm_sql_server" "sql_server" {
  name                         = "sql-overviews-master-data-${var.environment}"
  resource_group_name          = azurerm_resource_group.common.name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.sql_admin
  administrator_login_password = random_string.password.result
  tags = {
    environment = var.environment
  }
}

resource "azurerm_sql_database" "sql_database" {
  name                = "sqldb-overviews-master-data"
  resource_group_name = azurerm_resource_group.common.name
  location            = var.location
  server_name         = azurerm_sql_server.sql_server.name
}

resource "random_string" "password" {
  length           = 32
  special          = true
  override_special = "/@\" "
}

resource "azurerm_sql_firewall_rule" "sql_firewall" {
  name                = "access_to_sql_server"
  resource_group_name = azurerm_resource_group.common.name
  server_name         = azurerm_sql_server.sql_server.name
  start_ip_address    = var.home_ip
  end_ip_address      = var.home_ip
}

resource "azurerm_key_vault_secret" "sql_admin_login" {
  name         = "sqlAdminLogin"
  value        = var.sql_admin
  key_vault_id = azurerm_key_vault.kv.id
  depends_on = [
    azurerm_key_vault_access_policy.kv_access_policy
  ]
}

resource "azurerm_key_vault_secret" "sql_pass" {
  name         = "sqlAdminPass"
  value        = random_string.password.result
  key_vault_id = azurerm_key_vault.kv.id
  depends_on = [
    azurerm_key_vault_access_policy.kv_access_policy
  ]
}

resource "azurerm_key_vault_secret" "sql_server_dns" {
  name         = "sqlServerDNS"
  value        = "${azurerm_sql_server.sql_server.name}.database.windows.net"
  key_vault_id = azurerm_key_vault.kv.id

  depends_on = [
    azurerm_key_vault_access_policy.kv_access_policy,
  ]
}

