variable "kv_sku_name" {
  type    = string
  default = "standard"
}

variable "kv_tenant_id" {
  type = string
}

resource "azurerm_key_vault" "kv" {
  name                = "kv-${var.project}-${var.environment}"
  resource_group_name = azurerm_resource_group.common.name
  location            = azurerm_resource_group.common.location
  sku_name            = var.kv_sku_name
  tenant_id           = var.kv_tenant_id
  tags = {
    environment = var.environment
  }
}

resource "azurerm_key_vault_access_policy" "kv_access_policy" {

  for_each = var.access_policy_list

  key_vault_id            = azurerm_key_vault.kv.id
  tenant_id               = azurerm_key_vault.kv.tenant_id
  object_id               = each.key
  certificate_permissions = each.value["certificate_permissions"]
  key_permissions         = each.value["key_permissions"]
  secret_permissions      = each.value["secret_permissions"]
}

output "key_vault_access_policy_id" {
  value = azurerm_key_vault_access_policy.kv_access_policy
}

output "key_vault_id" {
  value = azurerm_key_vault.kv.id
}

output "key_vault_name" {
  value = azurerm_key_vault.kv.name
}

output "key_vault_tenant_id" {
  value = azurerm_key_vault.kv.tenant_id
}

output "key_vault_uri" {
  value = azurerm_key_vault.kv.vault_uri
}
