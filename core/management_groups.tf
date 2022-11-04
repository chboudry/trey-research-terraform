resource "azurerm_management_group" "TreyResearch" {
  name                       = "TreyResearch"
  display_name               = "TreyResearch"
}

resource "azurerm_management_group" "Platform" {
  name                       = "Platform"
  display_name               = "Platform"
  parent_management_group_id = azurerm_management_group.TreyResearch.id
}

resource "azurerm_management_group" "LandingZones" {
  name                       = "LandingZones"
  display_name               = "LandingZones"
  parent_management_group_id = azurerm_management_group.TreyResearch.id
}

resource "azurerm_management_group" "Sandboxes" {
  name                       = "Sandboxes"
  display_name               = "Sandboxes"
  parent_management_group_id = azurerm_management_group.TreyResearch.id
}

resource "azurerm_management_group" "Corp" {
  name                       = "Corp"
  display_name               = "Corp"
  parent_management_group_id = azurerm_management_group.LandingZones.id
}

resource "azurerm_management_group" "Online" {
  name                       = "Online"
  display_name               = "Online"
  parent_management_group_id = azurerm_management_group.LandingZones.id
}