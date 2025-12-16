resource "azurerm_network_security_group" "public" {
  name                = "${var.name}-public-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = merge(var.tags, {
    Name = "${var.name}-public-nsg"
  })
}

resource "azurerm_network_security_group" "private" {
  name                = "${var.name}-private-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = merge(var.tags, {
    Name = "${var.name}-private-nsg"
  })
}

resource "azurerm_network_security_group" "appgw" {
  name                = "${var.name}-appgw-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = merge(var.tags, {
    Name = "${var.name}-appgw-nsg"
  })
}

resource "azurerm_network_security_rule" "public" {
  for_each = var.public_nsg_rules

  name                         = each.key
  priority                     = each.value.priority
  direction                    = each.value.direction
  access                       = each.value.access
  protocol                     = each.value.protocol
  source_port_range            = each.value.source_port_ranges == null ? each.value.source_port_range : null
  destination_port_range       = each.value.destination_port_ranges == null ? each.value.destination_port_range : null
  source_port_ranges           = each.value.source_port_ranges
  destination_port_ranges      = each.value.destination_port_ranges
  source_address_prefix        = each.value.source_address_prefixes == null ? each.value.source_address_prefix : null
  destination_address_prefix   = each.value.destination_address_prefixes == null ? each.value.destination_address_prefix : null
  source_address_prefixes      = each.value.source_address_prefixes
  destination_address_prefixes = each.value.destination_address_prefixes
  resource_group_name          = var.resource_group_name
  network_security_group_name  = azurerm_network_security_group.public.name
}

resource "azurerm_network_security_rule" "private" {
  for_each = var.private_nsg_rules

  name                         = each.key
  priority                     = each.value.priority
  direction                    = each.value.direction
  access                       = each.value.access
  protocol                     = each.value.protocol
  source_port_range            = each.value.source_port_ranges == null ? each.value.source_port_range : null
  destination_port_range       = each.value.destination_port_ranges == null ? each.value.destination_port_range : null
  source_port_ranges           = each.value.source_port_ranges
  destination_port_ranges      = each.value.destination_port_ranges
  source_address_prefix        = each.value.source_address_prefixes == null ? each.value.source_address_prefix : null
  destination_address_prefix   = each.value.destination_address_prefixes == null ? each.value.destination_address_prefix : null
  source_address_prefixes      = each.value.source_address_prefixes
  destination_address_prefixes = each.value.destination_address_prefixes
  resource_group_name          = var.resource_group_name
  network_security_group_name  = azurerm_network_security_group.private.name
}

resource "azurerm_network_security_rule" "appgw" {
  for_each = var.appgw_nsg_rules

  name                         = each.key
  priority                     = each.value.priority
  direction                    = each.value.direction
  access                       = each.value.access
  protocol                     = each.value.protocol
  source_port_range            = each.value.source_port_ranges == null ? each.value.source_port_range : null
  destination_port_range       = each.value.destination_port_ranges == null ? each.value.destination_port_range : null
  source_port_ranges           = each.value.source_port_ranges
  destination_port_ranges      = each.value.destination_port_ranges
  source_address_prefix        = each.value.source_address_prefixes == null ? each.value.source_address_prefix : null
  destination_address_prefix   = each.value.destination_address_prefixes == null ? each.value.destination_address_prefix : null
  source_address_prefixes      = each.value.source_address_prefixes
  destination_address_prefixes = each.value.destination_address_prefixes
  resource_group_name          = var.resource_group_name
  network_security_group_name  = azurerm_network_security_group.appgw.name
}

resource "azurerm_subnet_network_security_group_association" "public" {
  count = var.public_subnet_count

  subnet_id                 = var.public_subnet_ids[count.index]
  network_security_group_id = azurerm_network_security_group.public.id
}

resource "azurerm_subnet_network_security_group_association" "private" {
  count = var.private_subnet_count

  subnet_id                 = var.private_subnet_ids[count.index]
  network_security_group_id = azurerm_network_security_group.private.id
}

resource "azurerm_subnet_network_security_group_association" "appgw" {
  subnet_id                 = var.appgw_subnet_id
  network_security_group_id = azurerm_network_security_group.appgw.id
}
