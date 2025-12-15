resource_groups = {
  prod = {
    name        = "aks-terraform-state-rg"
    location    = "northeurope"
    environment = "prod"
  }
}

storage_accounts = {
  prod = {
    name               = "akstfstate51ba7780"
    resource_group_key = "prod"
    environment        = "prod"
  }
}
