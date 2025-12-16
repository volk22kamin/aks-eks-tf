data "terraform_remote_state" "cluster" {
  backend = "azurerm"

  config = {
    resource_group_name  = var.cluster_state_resource_group
    storage_account_name = var.cluster_state_storage_account
    container_name       = var.cluster_state_container
    key                  = var.cluster_state_key
  }
}
