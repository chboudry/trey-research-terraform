resource "azurerm_virtual_network" "hub" {
  name                = "Hub"
  resource_group_name = azurerm_resource_group.rg-platform-connectivity.name
  address_space       = ["10.10.0.0/16"]
  location            = var.location
}

resource "azurerm_subnet" "firewall" {
    name                 = "AzureFirewallSubnet"
    resource_group_name  = azurerm_resource_group.rg-platform-connectivity.name
    virtual_network_name = azurerm_virtual_network.hub.name
    address_prefixes       = ["10.10.2.0/24"]
}

resource "azurerm_subnet" "identity" {
    name                 = "identity"
    resource_group_name  = azurerm_resource_group.rg-platform-connectivity.name
    virtual_network_name = azurerm_virtual_network.hub.name
    address_prefixes       = ["10.10.3.0/24"]
}

# Public IP For Azure Firewall
resource "azurerm_public_ip" "firewall-pip" {
  name                = "firewall-pip"
  resource_group_name = azurerm_resource_group.rg-platform-connectivity.name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Azure Firewall Instance
resource "azurerm_firewall" "firewall" {
  name                = "${var.company_prefix}firewall"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg-platform-connectivity.name
  sku_tier = "Premium"
  sku_name = "AZFW_VNet"
  ip_configuration {
    name                 = azurerm_public_ip.firewall-pip.name
    subnet_id            = azurerm_subnet.firewall.id
    public_ip_address_id = azurerm_public_ip.firewall-pip.id
  }
}