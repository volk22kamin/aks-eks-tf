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

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "prod"
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.28"
}

variable "vpc_state_bucket" {
  description = "S3 bucket where VPC state is stored"
  type        = string
}

variable "vpc_state_key" {
  description = "S3 key where VPC state is stored"
  type        = string
  default     = "vpc/terraform.tfstate"
}

variable "fargate_namespaces" {
  description = "List of Kubernetes namespaces for Fargate profiles"
  type        = list(string)
  default     = ["kube-system", "default"]
}

variable "default_tags" {
  description = "Default tags to apply to all resources"
  type        = map(string)
  default     = {}
}
