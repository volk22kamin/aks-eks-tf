output "resource_group_names" {
  description = "Names of the resource groups created"
  value       = { for k, v in azurerm_resource_group.tf_backend : k => v.name }
}

output "storage_account_names" {
  description = "Names of the storage accounts created"
  value       = { for k, v in azurerm_storage_account.tf_backend : k => v.name }
}

output "storage_container_names" {
  description = "Names of the storage containers created"
  value       = { for k, v in azurerm_storage_container.tf_backend : k => v.name }
}
