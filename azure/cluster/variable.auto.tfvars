cluster_name               = "prod-aks-cluster"
kubernetes_version         = "1.33.5"
vnet_state_resource_group  = "aks-terraform-state-rg"
vnet_state_storage_account = "akstfstate51ba7780"
vnet_state_container       = "tfstate"
vnet_state_key             = "vnet.tfstate"
node_count                 = 2
node_vm_size               = "Standard_D2s_v3"
default_tags = {
  Environment = "prod"
  Project     = "aks-migration"
  ManagedBy   = "Terraform"
}
