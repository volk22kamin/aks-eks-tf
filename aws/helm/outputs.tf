output "eks_cluster_id" {
  description = "EKS cluster ID from remote state"
  value       = data.terraform_remote_state.cluster.outputs.eks_cluster_id
}
