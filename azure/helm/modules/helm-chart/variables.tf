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

variable "atomic" {
  description = "Install/upgrade release atomically (roll back on failure)"
  type        = bool
  default     = false
}

variable "cleanup_on_fail" {
  description = "Allow deletion of new resources created during a failed install/upgrade"
  type        = bool
  default     = false
}

variable "replace" {
  description = "Re-use release name even if it already exists (useful to recover from stuck installs)"
  type        = bool
  default     = false
}

variable "wait" {
  description = "Wait for resources to be ready before marking release successful"
  type        = bool
  default     = true
}

variable "timeout" {
  description = "Time in seconds to wait for any individual Kubernetes operation"
  type        = number
  default     = 300
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
