data "terraform_remote_state" "vnet" {
  backend = "azurerm"

  config = {
    resource_group_name  = var.vnet_state_resource_group
    storage_account_name = var.vnet_state_storage_account
    container_name       = var.vnet_state_container
    key                  = var.vnet_state_key
  }
}
