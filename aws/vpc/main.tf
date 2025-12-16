module "vpc" {
  source = "./modules/vpc"

  vpc_cidr             = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  name                 = "${var.environment}-vpc"
  public_subnet_count  = var.public_subnet_count
  private_subnet_count = var.private_subnet_count
  enable_nat_gateway   = var.enable_nat_gateway
  cluster_name         = var.cluster_name
}
