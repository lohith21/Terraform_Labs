resource "azurerm_resource_group" "vnet_rg" {
  name     = "vnet-test"
  location = var.location
}

resource "azurerm_virtual_network" "vnet_dev" {
  name                = "vnet-dev"
  location            = azurerm_resource_group.vnet_rg.location
  resource_group_name = azurerm_resource_group.vnet_rg.name
  address_space       = ["10.0.0.0/16"]

  tags = {
    subscription = "Pay-As-You-Go"
  }

}

resource "azurerm_subnet" "subnet_dev" {
  count                = var.counts
  name                 = "subet-${count.index}"
  resource_group_name  = azurerm_resource_group.vnet_rg.name
  virtual_network_name = azurerm_virtual_network.vnet_dev.name
  address_prefixes     = ["[cidrsubnet(azurerm_virtual_network,vnet_dev.address_space, 8, count.index)]"]
}

resource "azurerm_virtual_network" "vnet_prod" {
  name                = "vnet-prod"
  location            = azurerm_resource_group.vnet_rg.location
  resource_group_name = azurerm_resource_group.vnet_rg.name
  address_space       = ["10.1.0.0/16"]

  tags = {
    subscription = "Pay-As-You-Go"
  }

}

resource "azurerm_subnet" "subnet_prod" {
  count                = var.counts
  name                 = "subet-${count.index}"
  resource_group_name  = azurerm_resource_group.vnet_rg.name
  virtual_network_name = azurerm_virtual_network.vnet_prod.name
  address_prefixes     = ["[cidrsubnet(azurerm_virtual_network.vnet_prod.address_space, 8, count.index)]"]
}
