terraform {
  backend "azurerm" {
    resource_group_name  = "aks-terraform-state-rg"
    storage_account_name = "akstfstate51ba7780"
    container_name       = "tfstate"
    key                  = "helm.tfstate"
  }
}
