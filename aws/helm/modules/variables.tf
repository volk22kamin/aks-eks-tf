variable "release_name" {
  description = "Name of the Helm release"
  type        = string
}

variable "chart_repository" {
  description = "Helm chart repository URL"
  type        = string
}

variable "chart_name" {
  description = "Name of the Helm chart"
  type        = string
}

variable "chart_version" {
  description = "Version of the Helm chart"
  type        = string
  default     = ""
}

variable "namespace" {
  description = "Kubernetes namespace for the release"
  type        = string
  default     = "default"
}

variable "create_namespace" {
  description = "Create the namespace if it does not exist"
  type        = bool
  default     = false
}

variable "values_files" {
  description = "List of values files content"
  type        = list(string)
  default     = []
}

variable "set_values" {
  description = "Map of values to set"
  type        = map(string)
  default     = {}
}
