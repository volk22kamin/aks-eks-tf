output "cluster_id" {
  description = "The ID of the AKS cluster"
  value       = module.aks.cluster_id
}

output "cluster_name" {
  description = "The name of the AKS cluster"
  value       = module.aks.cluster_name
}

output "kube_config" {
  description = "Kubernetes configuration"
  value       = module.aks.kube_config
  sensitive   = true
}

output "managed_identity_client_id" {
  description = "The client ID of the managed identity"
  value       = module.aks.managed_identity_client_id
}

output "application_gateway_id" {
  description = "The ID of the Application Gateway"
  value       = module.aks.application_gateway_id
}

output "application_gateway_name" {
  description = "The name of the Application Gateway"
  value       = module.aks.application_gateway_name
}

output "application_gateway_public_ip" {
  description = "The public IP of the Application Gateway"
  value       = module.aks.application_gateway_public_ip
}

output "subscription_id" {
  description = "The Azure subscription ID"
  value       = module.aks.subscription_id
}

output "resource_group_name" {
  description = "The name of the resource group"
  value       = module.aks.resource_group_name
}

output "cluster_fqdn" {
  description = "The FQDN of the AKS cluster"
  value       = module.aks.cluster_fqdn
}

output "managed_identity_id" {
  description = "The ID of the managed identity"
  value       = module.aks.managed_identity_id
}
