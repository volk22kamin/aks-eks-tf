resource "azurerm_virtual_network" "this" {
  name                = "${var.name}-vnet"
  address_space       = var.vnet_address_space
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = merge(var.tags, {
    Name = "${var.name}-vnet"
  })
}

resource "azurerm_subnet" "public" {
  count = var.public_subnet_count

  name                 = "${var.name}-public-subnet-${count.index + 1}"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [cidrsubnet(var.vnet_address_space[0], 8, count.index)]
}

resource "azurerm_subnet" "private" {
  count = var.private_subnet_count

  name                 = "${var.name}-private-subnet-${count.index + 1}"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [cidrsubnet(var.vnet_address_space[0], 8, count.index + var.public_subnet_count)]
}

resource "azurerm_subnet" "appgw" {
  name                 = "${var.name}-appgw-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [cidrsubnet(var.vnet_address_space[0], 8, var.public_subnet_count + var.private_subnet_count)]
}

resource "azurerm_public_ip" "nat" {
  count = var.enable_nat_gateway ? 1 : 0

  name                = "${var.name}-nat-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = merge(var.tags, {
    Name = "${var.name}-nat-pip"
  })
}

resource "azurerm_nat_gateway" "this" {
  count = var.enable_nat_gateway ? 1 : 0

  name                = "${var.name}-nat-gateway"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "Standard"

  tags = merge(var.tags, {
    Name = "${var.name}-nat-gateway"
  })
}

resource "azurerm_nat_gateway_public_ip_association" "this" {
  count = var.enable_nat_gateway ? 1 : 0

  nat_gateway_id       = azurerm_nat_gateway.this[0].id
  public_ip_address_id = azurerm_public_ip.nat[0].id
}

resource "azurerm_subnet_nat_gateway_association" "private" {
  count = var.enable_nat_gateway ? var.private_subnet_count : 0

  subnet_id      = azurerm_subnet.private[count.index].id
  nat_gateway_id = azurerm_nat_gateway.this[0].id
}


module "nsg" {
  source = "../nsg"
  count  = var.enable_nsgs ? 1 : 0

  name                 = var.name
  location             = var.location
  resource_group_name  = var.resource_group_name
  public_subnet_ids    = azurerm_subnet.public[*].id
  private_subnet_ids   = azurerm_subnet.private[*].id
  appgw_subnet_id      = azurerm_subnet.appgw.id
  public_subnet_count  = var.public_subnet_count
  private_subnet_count = var.private_subnet_count
  public_nsg_rules     = var.public_nsg_rules
  private_nsg_rules    = var.private_nsg_rules
  appgw_nsg_rules      = var.appgw_nsg_rules
  tags                 = var.tags
}
