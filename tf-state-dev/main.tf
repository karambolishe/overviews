terraform {
  backend "azurerm" {
    resource_group_name   = "rg-overviews-tf-dev"
    storage_account_name  = "overviewstfdev"
    container_name        = "overviews-dev"
    key                   = "terraform.tfstate"
  }
}