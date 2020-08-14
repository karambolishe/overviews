terraform {
  backend "azurerm" {
    resource_group_name   = "rg-overviews-tf-test"
    storage_account_name  = "overviewstftest"
    container_name        = "overviews-test"
    key                   = "terraform.tfstate"
  }
}