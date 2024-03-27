output "vnet_rg_id" {
  value = azurerm_resource_group.vnet_rg.id
  description = "Outputting the id of VNet module resource group"
}