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

resource "azurerm_public_ip" "bastion_ip" {
  name                = "${var.company_prefix}public-ip-bastion"
  location            = azurerm_resource_group.rg-platform-mgmt.location
  resource_group_name = azurerm_resource_group.rg-platform-mgmt.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "jumphost_bastion" {
  name                = "${var.company_prefix}bastion-host"
  location            = azurerm_resource_group.rg-platform-mgmt.location
  resource_group_name = azurerm_resource_group.rg-platform-mgmt.name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.bastion.id
    public_ip_address_id = azurerm_public_ip.bastion_ip.id
  }
}