variable "cluster_state_resource_group" {
  description = "Resource group where cluster state is stored"
  type        = string
}

variable "cluster_state_storage_account" {
  description = "Storage account where cluster state is stored"
  type        = string
}

variable "cluster_state_container" {
  description = "Container where cluster state is stored"
  type        = string
  default     = "tfstate"
}

variable "cluster_state_key" {
  description = "Key where cluster state is stored"
  type        = string
  default     = "cluster.tfstate"
}
