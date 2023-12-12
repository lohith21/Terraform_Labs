terraform {
  backend "azurerm" {
    storage_account_name = "csg10032000db7cab9f"
    container_name = "terraform-state"
    key = "prod.terraform.tfstate"
    access_key = "dE1YafP3H/Q3P7PPo/fciXdu29cvGmm4AxRcfpjcMaA7Dd1fj9Br5mi+CjQ+QZEsy2mXaaZLAI81+AStV1MaNg=="
  }