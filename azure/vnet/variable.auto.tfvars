environment          = "prod"
location             = "northeurope"
public_subnet_count  = 2
private_subnet_count = 2
default_tags = {
  Environment = "prod"
  Project     = "mend"
  ManagedBy   = "Terraform"
}
cluster_name       = "aks-cluster"
enable_nat_gateway = true
