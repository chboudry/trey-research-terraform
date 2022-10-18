resource "azurerm_resource_group" "rg-platform-mgmt" {
  name     = var.TreyResearch-mgmt-rg-name
  location = var.location
}

resource "azurerm_resource_group" "rg-platform-connectivity" {
  name     = var.TreyResearch-connectivity-rg-name
  location = var.location
}

resource "azurerm_resource_group" "rg-platform-identity" {
  name     = var.TreyResearch-identity-rg-name
  location = var.location
}
