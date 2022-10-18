resource "azurerm_log_analytics_workspace" "management" {
  # Mandatory resource attributes
  name                = "TreyResearch-LA"
  location            = var.location
  resource_group_name = var.TreyResearch-mgmt-rg-name
}