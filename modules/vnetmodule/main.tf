locals {
    vnetmodule_rg = "VNET_Module_ResourceGroup"
    environment_name = "test"
}

resource "azurerm_resource_group" "vnet_rg" {
  name     = local.vnetmodule_rg
  location = var.vnet_location
  tags = {
    Environment = local.environment_name
    Team        = "Cloud DataEngineer"
  }
}