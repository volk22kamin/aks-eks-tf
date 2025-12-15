variable "resource_groups" {
  description = "Map of resource groups to create for backend storage"
  type = map(object({
    name        = string
    location    = string
    environment = string
    tags        = optional(map(string), {})
  }))
}

variable "storage_accounts" {
  description = "Map of storage accounts to create for Terraform state"
  type = map(object({
    name               = string
    resource_group_key = string
    environment        = string
    tags               = optional(map(string), {})
  }))
}
