output "public_nsg_id" {
  description = "ID of the public subnet NSG"
  value       = azurerm_network_security_group.public.id
}

output "public_nsg_name" {
  description = "Name of the public subnet NSG"
  value       = azurerm_network_security_group.public.name
}

output "private_nsg_id" {
  description = "ID of the private subnet NSG"
  value       = azurerm_network_security_group.private.id
}

output "private_nsg_name" {
  description = "Name of the private subnet NSG"
  value       = azurerm_network_security_group.private.name
}

output "appgw_nsg_id" {
  description = "ID of the Application Gateway subnet NSG"
  value       = azurerm_network_security_group.appgw.id
}

output "appgw_nsg_name" {
  description = "Name of the Application Gateway subnet NSG"
  value       = azurerm_network_security_group.appgw.name
}
