variable "cluster_name" {
  description = "Name of the AKS cluster"
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.31"
}

variable "vnet_state_resource_group" {
  description = "Resource group where VNet state is stored"
  type        = string
}

variable "vnet_state_storage_account" {
  description = "Storage account where VNet state is stored"
  type        = string
}

variable "vnet_state_container" {
  description = "Container where VNet state is stored"
  type        = string
  default     = "tfstate"
}

variable "vnet_state_key" {
  description = "Key where VNet state is stored"
  type        = string
  default     = "vnet.tfstate"
}

variable "node_count" {
  description = "Number of nodes in the default node pool"
  type        = number
  default     = 2
}

variable "node_vm_size" {
  description = "VM size for the default node pool"
  type        = string
  default     = "Standard_D2s_v3"
}

variable "default_tags" {
  description = "Default tags to apply to all resources"
  type        = map(string)
  default     = {}
}
