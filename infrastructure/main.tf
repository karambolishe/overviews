terraform {
  required_providers {
    azurerm = "=2.20.0"
    azuread = "=0.11"
    random  = "=2.3"
  }
  backend "azurerm" {
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "common" {
  name     = "rg-${var.project}-${var.environment}"
  location = var.location

  tags = {
    environment = var.environment
  }
}

resource "azuread_group" "az_group" {
  name     = "Researcher_SEC"
  members  = var.user_ids
}

resource "azurerm_key_vault_secret" "sg_id" {
  name         = "researcherSecGroupId"
  value        = azuread_group.az_group.id
  key_vault_id = azurerm_key_vault.kv.id
  depends_on = [
    azurerm_key_vault_access_policy.kv_access_policy
  ]

}