variable "buckets" {
  description = "Map of S3 buckets to create, keyed by a friendly name."
  type = map(object({
    bucket_name_prefix = string
    environment        = string
    tags               = optional(map(string), {})
  }))
}

variable "region" {
  description = "The AWS region to create resources in."
  type        = string
  default     = "eu-central-1"
}

variable "enable_dynamodb_lock_table" {
  description = "Whether to create a DynamoDB table for Terraform state locking alongside each bucket."
  type        = bool
  default     = false
}

variable "dynamodb_lock_table_name" {
  description = "Optional name for the shared DynamoDB lock table. Defaults to tf-state-lock-<account_id> when enabled."
  type        = string
  default     = null
}
