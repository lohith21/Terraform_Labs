resource "azurerm_storage_account" "vnet-store" {
  name                     = "vnetstorefortest"
  resource_group_name      = azurerm_resource_group.vnet-rg.name
  location                 = azurerm_resource_group.vnet-rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_monitor_diagnostic_setting" "vnet-diag" {
  name               = "vnet-diag"
  target_resource_id = azurerm_virtual_network.vnet-to-vnet.id
  storage_account_id = azurerm_storage_account.vnet-store.id

  enabled_log {
    category = "VMProtectionAlerts"

    retention_policy {
      days = 0
      enabled = false
    }
  }

  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = false
    }
  }
}