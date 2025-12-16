output "vnet_id" {
  description = "The ID of the Virtual Network"
  value       = azurerm_virtual_network.this.id
}

output "vnet_name" {
  description = "The name of the Virtual Network"
  value       = azurerm_virtual_network.this.name
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = azurerm_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = azurerm_subnet.private[*].id
}

output "appgw_subnet_id" {
  description = "Application Gateway subnet ID"
  value       = azurerm_subnet.appgw.id
}

output "resource_group_name" {
  description = "Name of the resource group"
  value       = var.resource_group_name
}

output "location" {
  description = "Azure region location"
  value       = var.location
}

output "public_nsg_id" {
  description = "ID of the public subnet NSG"
  value       = var.enable_nsgs ? module.nsg[0].public_nsg_id : null
}

output "public_nsg_name" {
  description = "Name of the public subnet NSG"
  value       = var.enable_nsgs ? module.nsg[0].public_nsg_name : null
}

output "private_nsg_id" {
  description = "ID of the private subnet NSG"
  value       = var.enable_nsgs ? module.nsg[0].private_nsg_id : null
}

output "private_nsg_name" {
  description = "Name of the private subnet NSG"
  value       = var.enable_nsgs ? module.nsg[0].private_nsg_name : null
}

output "appgw_nsg_id" {
  description = "ID of the Application Gateway subnet NSG"
  value       = var.enable_nsgs ? module.nsg[0].appgw_nsg_id : null
}

output "appgw_nsg_name" {
  description = "Name of the Application Gateway subnet NSG"
  value       = var.enable_nsgs ? module.nsg[0].appgw_nsg_name : null
}
