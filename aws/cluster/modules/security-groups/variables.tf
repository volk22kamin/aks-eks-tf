variable "vpc_id" {
  description = "VPC ID where security groups will be created"
  type        = string
}

variable "security_groups" {
  description = "Map of security groups to create"
  type = map(object({
    name        = string
    description = string
    ingress_rules = optional(list(object({
      description               = optional(string)
      from_port                 = number
      to_port                   = number
      protocol                  = string
      cidr_blocks               = optional(list(string))
      ipv6_cidr_blocks          = optional(list(string))
      source_security_group_id  = optional(string)
      source_security_group_key = optional(string)
    })), [])
    egress_rules = optional(list(object({
      description               = optional(string)
      from_port                 = number
      to_port                   = number
      protocol                  = string
      cidr_blocks               = optional(list(string))
      ipv6_cidr_blocks          = optional(list(string))
      source_security_group_id  = optional(string)
      source_security_group_key = optional(string)
    })), [])
    tags = optional(map(string), {})
  }))
  default = {}
}

variable "default_tags" {
  description = "Default tags to apply to all security groups"
  type        = map(string)
  default     = {}
}
