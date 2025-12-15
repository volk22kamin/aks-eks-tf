output "vnet_id" {
  description = "The ID of the Virtual Network"
  value       = module.vnet.vnet_id
}

output "vnet_name" {
  description = "The name of the Virtual Network"
  value       = module.vnet.vnet_name
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = module.vnet.public_subnet_ids
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = module.vnet.private_subnet_ids
}

output "appgw_subnet_id" {
  description = "Application Gateway subnet ID"
  value       = module.vnet.appgw_subnet_id
}

output "resource_group_name" {
  description = "Name of the resource group"
  value       = azurerm_resource_group.this.name
}

output "location" {
  description = "Azure region location"
  value       = var.location
}
