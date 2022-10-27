resource "azurerm_log_analytics_workspace" "managementLA" {
  name                = "${var.company_prefix}LA"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg-platform-mgmt.name
}

resource "azurerm_log_analytics_solution" "managementSentinel" {
  solution_name         = "SecurityInsights"
  location              = var.location
  resource_group_name   = azurerm_resource_group.rg-platform-mgmt.name
  workspace_resource_id = azurerm_log_analytics_workspace.managementLA.id
  workspace_name        = azurerm_log_analytics_workspace.managementLA.name
  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/SecurityInsights"
  }
}

resource "azurerm_automation_account" "managementAA" {
  name                = "${var.company_prefix}AA"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg-platform-mgmt.name
  sku_name            = "Basic"
}