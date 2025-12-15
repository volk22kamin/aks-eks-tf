region      = "eu-north-1"
aws_profile = "mend"
environment = "prod"

cluster_name    = "mend-eks-cluster"
cluster_version = "1.31"

vpc_state_bucket = "mend-state-739929374881"
vpc_state_key    = "vpc/terraform.tfstate"

fargate_namespaces = ["kube-system", "default"]

default_tags = {
  Environment = "prod"
  Project     = "mend"
  ManagedBy   = "Terraform"
}
