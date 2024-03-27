output "hello-world" {
  description = "Just prints Hello world"
  value       = "Hello World!"
}

output "resource_group_id" {
  description = "Outputs the Azure Resource Group ID"
  value       = azurerm_resource_group.rg.id
}

output "resource_group_name_output" {
  value     = azurerm_resource_group.rg.name
  sensitive = true
}

output "maximum" {
  value = max(var.num1, var.num2, var.num3)
}

output "minimum" {
  value = min(var.num1, var.num2, var.num3, 10, 5)
}