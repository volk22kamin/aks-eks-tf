variable "name" {
  description = "Base name for NSG resources"
  type        = string
}

variable "location" {
  description = "Azure region for NSG resources"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs to associate with public NSG"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs to associate with private NSG"
  type        = list(string)
}

variable "appgw_subnet_id" {
  description = "Application Gateway subnet ID to associate with appgw NSG"
  type        = string
}

variable "public_subnet_count" {
  description = "Number of public subnets"
  type        = number
}

variable "private_subnet_count" {
  description = "Number of private subnets"
  type        = number
}

variable "tags" {
  description = "Tags to apply to NSG resources"
  type        = map(string)
  default     = {}
}

variable "public_nsg_rules" {
  description = "Map of security rules for public subnet NSG"
  type = map(object({
    priority                     = number
    direction                    = string
    access                       = string
    protocol                     = string
    source_port_range            = optional(string, "*")
    destination_port_range       = optional(string, "*")
    source_port_ranges           = optional(list(string))
    destination_port_ranges      = optional(list(string))
    source_address_prefix        = optional(string)
    destination_address_prefix   = optional(string)
    source_address_prefixes      = optional(list(string))
    destination_address_prefixes = optional(list(string))
  }))
  default = {}
}

variable "private_nsg_rules" {
  description = "Map of security rules for private subnet NSG"
  type = map(object({
    priority                     = number
    direction                    = string
    access                       = string
    protocol                     = string
    source_port_range            = optional(string, "*")
    destination_port_range       = optional(string, "*")
    source_port_ranges           = optional(list(string))
    destination_port_ranges      = optional(list(string))
    source_address_prefix        = optional(string)
    destination_address_prefix   = optional(string)
    source_address_prefixes      = optional(list(string))
    destination_address_prefixes = optional(list(string))
  }))
  default = {}
}

variable "appgw_nsg_rules" {
  description = "Map of security rules for Application Gateway subnet NSG"
  type = map(object({
    priority                     = number
    direction                    = string
    access                       = string
    protocol                     = string
    source_port_range            = optional(string, "*")
    destination_port_range       = optional(string, "*")
    source_port_ranges           = optional(list(string))
    destination_port_ranges      = optional(list(string))
    source_address_prefix        = optional(string)
    destination_address_prefix   = optional(string)
    source_address_prefixes      = optional(list(string))
    destination_address_prefixes = optional(list(string))
  }))
  default = {}
}
