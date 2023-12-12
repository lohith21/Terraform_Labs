#### Azure Virtual Network

resource "azurerm_virtual_network" "vnet-to-vnet" {
  name                = "vnet-network"
  location            = azurerm_resource_group.vnet-rg.location
  resource_group_name = azurerm_resource_group.vnet-rg.name
  address_space       = var.vnet_cidr_block

  tags = {
    environment = "Devlopment"
  }

}

### Azure Subnets

resource "azurerm_subnet" "subnets" {
  count                = var.vnet_subnet_count 
  name                 = var.subnet_names[count.index]
  resource_group_name  = azurerm_resource_group.vnet-rg.name
  virtual_network_name = azurerm_virtual_network.vnet-to-vnet.name
  address_prefixes     = [var.vnet_cidr_subnet_dev[count.index]]
}

/*resource "azurerm_subnet" "subnet02" {
  name                 = "accounts"
  resource_group_name  = azurerm_resource_group.vnet-rg.name
  virtual_network_name = azurerm_virtual_network.vnet-to-vnet.name
  address_prefixes     = [var.vnet_cidr_subnet_block[1]]
}*/

#### Network Security Group

resource "azurerm_network_security_group" "vnet-nsg" {
  name                = "vnet-dev-nsg"
  location            = azurerm_resource_group.vnet-rg.location
  resource_group_name = azurerm_resource_group.vnet-rg.name

  security_rule {
    name                       = "traffic-in"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "traffic-out"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  tags = {
    environment = "Development"
  }

}

#########  NSG to subnet association

resource "azurerm_subnet_network_security_group_association" "nsg-to-subnet-dev" {
  count                     = var.vnet_subnet_count
  subnet_id                 = azurerm_subnet.subnets[count.index].id
  network_security_group_id = azurerm_network_security_group.vnet-nsg.id
}

###### Azure Flow Log Activation

resource "azurerm_network_watcher" "vnet-watcher" {
  name                = "vnet-flow-watcher"
  location            = azurerm_resource_group.vnet-rg.location
  resource_group_name = azurerm_resource_group.vnet-rg.name
}

resource "azurerm_network_watcher_flow_log" "vnet-flow" {
  network_watcher_name = azurerm_network_watcher.vnet-watcher.name
  resource_group_name  = azurerm_resource_group.vnet-rg.name
  name                 = "vnet-flow-logs"

  network_security_group_id = azurerm_network_security_group.vnet-nsg.id
  storage_account_id        = azurerm_storage_account.vnet-store.id
  enabled                   = true

  retention_policy {
    enabled = true
    days    = 7
  }
}