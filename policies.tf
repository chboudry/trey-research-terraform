resource "azurerm_policy_definition" "resource_location" {
  name                  = "resource-location"
  policy_type           = "Custom"
  mode                  = "All"
  display_name          = "Resource Location"
  management_group_id = azurerm_management_group.TreyResearch.id
  policy_rule           = file("./policies/resource-location/policy-rule.json")
  parameters            = file("./policies/resource-location/policy-parameters.json")
}

resource "azurerm_management_group_policy_assignment" "resource_location_assignment" {
  name                 = "Resource-location"
  management_group_id  = azurerm_management_group.TreyResearch.id
  policy_definition_id = azurerm_policy_definition.resource_location.id
  display_name         = "Only allowing West Europe and north Europe"
  parameters           = <<PARAMETERS
{
  "allowedLocations": {
    "value": [ "westeurope", "northeurope" ]
  }
}
PARAMETERS
}
