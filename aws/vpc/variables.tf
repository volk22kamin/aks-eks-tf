variable "public_subnet_count" {
  description = "Number of public subnets to create in the VPC"
  type        = number
}

variable "private_subnet_count" {
  description = "Number of private subnets to create in the VPC"
  type        = number
}

variable "region" {
  description = "AWS region to deploy resources in"
  type        = string
}

variable "default_tags" {
  description = "Default tags to apply to all resources"
  type        = map(string)
}

variable "environment" {
  description = "Deployment environment (e.g., dev, staging, prod)"
  type        = string
}

variable "enable_nat_gateway" {
  description = "Whether to create a NAT Gateway for private subnets"
  type        = bool
  default     = false
}

variable "cluster_name" {
  description = "Name of the EKS cluster associated with this VPC"
  type        = string
  default     = ""
}

variable "profile" {
  description = "AWS profile to use for authentication"
  type        = string
  default     = "default"
}