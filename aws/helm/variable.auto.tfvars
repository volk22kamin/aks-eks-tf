region      = "eu-north-1"
aws_profile = "mend"

cluster_state_bucket = "mend-state-739929374881" 
cluster_state_key    = "cluster/terraform.tfstate"

default_tags = {
  Environment = "prod"
  Project     = "mend"
  ManagedBy   = "Terraform"
}
