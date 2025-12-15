resource "azurerm_resource_group" "this" {
  name     = "${var.environment}-aks-rg"
  location = var.location

  tags = var.default_tags
}

module "vnet" {
  source = "./modules/vnet"

  vnet_address_space   = ["10.0.0.0/16"]
  name                 = "${var.environment}-aks"
  location             = var.location
  resource_group_name  = azurerm_resource_group.this.name
  public_subnet_count  = var.public_subnet_count
  private_subnet_count = var.private_subnet_count
  enable_nat_gateway   = var.enable_nat_gateway
  cluster_name         = var.cluster_name
  tags                 = var.default_tags
}
