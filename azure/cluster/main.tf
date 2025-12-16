module "aks" {
  source = "./modules/aks"

  cluster_name        = var.cluster_name
  kubernetes_version  = var.kubernetes_version
  vnet_id             = data.terraform_remote_state.vnet.outputs.vnet_id
  private_subnet_ids  = data.terraform_remote_state.vnet.outputs.private_subnet_ids
  appgw_subnet_id     = data.terraform_remote_state.vnet.outputs.appgw_subnet_id
  resource_group_name = data.terraform_remote_state.vnet.outputs.resource_group_name
  location            = data.terraform_remote_state.vnet.outputs.location
  node_count          = var.node_count
  node_vm_size        = var.node_vm_size
  default_tags        = var.default_tags
}
