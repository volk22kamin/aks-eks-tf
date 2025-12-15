output "vpc_id" {
  description = "VPC ID from remote state"
  value       = data.terraform_remote_state.vpc.outputs.vpc_id
}

output "eks_cluster_id" {
  description = "EKS cluster ID"
  value       = module.eks.cluster_id
}

output "eks_cluster_endpoint" {
  description = "EKS cluster endpoint"
  value       = module.eks.cluster_endpoint
}

output "eks_cluster_certificate_authority_data" {
  description = "EKS cluster certificate authority data"
  value       = module.eks.cluster_certificate_authority_data
  sensitive   = true
}

output "eks_cluster_oidc_issuer_url" {
  description = "EKS cluster OIDC issuer URL"
  value       = module.eks.cluster_oidc_issuer_url
}

output "eks_cluster_version" {
  description = "EKS cluster Kubernetes version"
  value       = module.eks.cluster_version
}

output "aws_load_balancer_controller_role_arn" {
  description = "IAM role ARN for AWS Load Balancer Controller"
  value       = module.eks.aws_load_balancer_controller_role_arn
}

output "configure_kubectl" {
  description = "Command to configure kubectl"
  value       = "aws eks update-kubeconfig --name ${module.eks.cluster_id} --region ${var.region}"
}

output "caller_identity" {
  description = "AWS caller identity used for this plan/apply"
  value = {
    account_id = data.aws_caller_identity.current.account_id
    arn        = data.aws_caller_identity.current.arn
    user_id    = data.aws_caller_identity.current.user_id
  }
}
