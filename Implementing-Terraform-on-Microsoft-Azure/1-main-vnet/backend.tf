terraform {
  backend "azurerm" {
    storage_account_name = "itma41983"
    container_name       = "terraform-state"
    key                  = "terraform.tfstate"
  }
}