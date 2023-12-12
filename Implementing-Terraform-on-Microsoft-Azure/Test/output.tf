output "vnet_id_dev" {
  value = azurerm_virtual_network.vnet_dev.id
}

output "vnet_id_prod" {
  value = azurerm_virtual_network.vnet_prod.id
}

output "rg_location" {
  value = azurerm_resource_group.vnet_rg.location
}

output "vnet_name_Dev" {
  value = azurerm_virtual_network.vnet_dev.name
}

output "vnet_name_Prod" {
  value = azurerm_virtual_network.vnet_prod.name
}