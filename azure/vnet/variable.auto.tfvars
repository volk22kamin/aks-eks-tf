environment          = "prod"
location             = "northeurope"
public_subnet_count  = 2
private_subnet_count = 2
default_tags = {
  Environment = "prod"
  Project     = "mend"
  ManagedBy   = "Terraform"
}
cluster_name       = "aks-cluster"
enable_nat_gateway = true

public_nsg_rules = {
  "AllowHTTPInbound" = {
    priority                   = 500
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    destination_port_range     = "80"
    source_address_prefixes    = ["0.0.0.0/0"]
    destination_address_prefix = "*"
  }
  "AllowHTTPSInbound" = {
    priority                   = 510
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    destination_port_range     = "443"
    source_address_prefixes    = ["0.0.0.0/0"]
    destination_address_prefix = "*"
  }
  "AllowVNetInbound" = {
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "VirtualNetwork"
  }
  "AllowAllOutbound" = {
    priority                   = 4000
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

private_nsg_rules = {
  "AllowVNetInbound" = {
    priority                   = 500
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "VirtualNetwork"
  }
  "AllowInternetOutbound" = {
    priority                   = 1000
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "Internet"
  }
  "AllowVNetOutbound" = {
    priority                   = 1010
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "VirtualNetwork"
  }
}

appgw_nsg_rules = {
  "AllowHTTPInbound" = {
    priority                   = 500
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    destination_port_range     = "80"
    source_address_prefixes    = ["0.0.0.0/0"]
    destination_address_prefix = "*"
  }
  "AllowHTTPSInbound" = {
    priority                   = 510
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    destination_port_range     = "443"
    source_address_prefixes    = ["0.0.0.0/0"]
    destination_address_prefix = "*"
  }
  "AllowGatewayManagerInbound" = {
    priority                   = 520
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    destination_port_range     = "65200-65535"
    source_address_prefix      = "GatewayManager"
    destination_address_prefix = "*"
  }
  "AllowAzureLoadBalancerInbound" = {
    priority                   = 530
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_address_prefix      = "AzureLoadBalancer"
    destination_address_prefix = "*"
  }
  "AllowVNetOutbound" = {
    priority                   = 1000
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "VirtualNetwork"
  }
  "AllowInternetOutbound" = {
    priority                   = 1010
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "Internet"
  }
}
