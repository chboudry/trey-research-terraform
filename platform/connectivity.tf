resource "azurerm_virtual_network" "hub" {
  name                = "Hub"
  resource_group_name = var.TreyResearch-connectivity-rg-name
  address_space       = ["10.10.0.0/16"]
  location            = var.location
}