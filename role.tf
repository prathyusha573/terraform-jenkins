data "azurerm_subscription" "primary" {
  subscription_id = var.subscription_id
}

data "azurerm_client_config" "example" {}

resource "azurerm_role_definition" "roledef" {
  name  = "my-custom-role-definition"
  scope = data.azurerm_subscription.primary.id

  permissions {
    actions     = ["Microsoft.Resources/subscriptions/resourceGroups/read"]
    not_actions = []
  }

  assignable_scopes = [
    data.azurerm_subscription.primary.id,
  ]
}

resource "azurerm_role_assignment" "roleassignment" {
  name               = "7a6d05fd-b173-4c3d-9f08-2684f62a354b" //Generated from GUID generator
  scope              = data.azurerm_subscription.primary.id
  role_definition_id = azurerm_role_definition.roledef.role_definition_resource_id
  principal_id       = data.azurerm_client_config.example.object_id
}
