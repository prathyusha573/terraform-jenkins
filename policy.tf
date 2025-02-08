data "azurerm_subscription" "current" {}

resource "azurerm_policy_definition" "policydef" {
  name         = "only-deploy-in-westeurope"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Allowed resource types"

  policy_rule = <<POLICY_RULE
 {
    "if": {
      "not": {
        "field": "location",
        "equals": "westeurope"
      }
    },
    "then": {
      "effect": "Deny"
    }
  }
POLICY_RULE
}

resource "azurerm_subscription_policy_assignment" "policy_assign1" {
  name                 = "example_policy"
  policy_definition_id = azurerm_policy_definition.policydef.id
  subscription_id      = data.azurerm_subscription.current.id
}