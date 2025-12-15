resource "azurerm_resource_group" "tf_backend" {
  for_each = var.resource_groups
  name     = each.value.name
  location = each.value.location

  tags = merge({
    Name        = "Terraform State Resource Group"
    Environment = each.value.environment
  }, try(each.value.tags, {}))
}

resource "azurerm_storage_account" "tf_backend" {
  for_each = var.storage_accounts

  name                     = each.value.name
  resource_group_name      = azurerm_resource_group.tf_backend[each.value.resource_group_key].name
  location                 = azurerm_resource_group.tf_backend[each.value.resource_group_key].location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"

  blob_properties {
    versioning_enabled = true
  }

  tags = merge({
    Name        = "Terraform State Storage Account"
    Environment = each.value.environment
  }, try(each.value.tags, {}))
}

resource "azurerm_storage_container" "tf_backend" {
  for_each = var.storage_accounts

  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.tf_backend[each.key].name
  container_access_type = "private"
}
