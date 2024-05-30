output "rg_name" {
  value = { for rg in azurerm_resource_group.rg : rg.name => rg.name }
}

output "rg_tags" {
  value = values({ for k, v in azurerm_resource_group.rg : k => v.tags })
}

output "rg_id" {
  value = values({ for k, v in azurerm_resource_group.rg : k => v.id })
}

output "all" {
  value = azurerm_resource_group.rg
}

output "rg_location" {
  value       = { for k, rg in azurerm_resource_group.rg : k => rg.location }
  description = "The location of each resource group"
}