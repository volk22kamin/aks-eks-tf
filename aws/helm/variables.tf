variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-north-1"
}

variable "aws_profile" {
  description = "AWS CLI profile to use"
  type        = string
  default     = "mend"
}

variable "cluster_state_bucket" {
  description = "S3 bucket where cluster state is stored"
  type        = string
}

variable "cluster_state_key" {
  description = "S3 key where cluster state is stored"
  type        = string
  default     = "cluster/terraform.tfstate"
}

variable "default_tags" {
  description = "Default tags to apply to all resources"
  type        = map(string)
  default     = {}
}
