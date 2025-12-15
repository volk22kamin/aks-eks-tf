data "aws_caller_identity" "current" {}

module "security_groups" {
  source = "./modules/security-groups"

  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
  security_groups = {
    alb = {
      name        = "${var.environment}-alb-sg"
      description = "Security group for Application Load Balancer"
      ingress_rules = var.alb_security_group_ingress_rules
      egress_rules  = var.alb_security_group_egress_rules
      tags = {
        Purpose = "ALB"
      }
    }
  }
  default_tags = var.default_tags
}

module "alb" {
  source = "./modules/alb"

  name               = var.alb_name
  vpc_id             = data.terraform_remote_state.vpc.outputs.vpc_id
  subnet_ids         = data.terraform_remote_state.vpc.outputs.public_subnet_ids
  security_group_ids = [module.security_groups.security_group_ids["alb"]]
  default_tags       = var.default_tags
}

# EKS Cluster
module "eks" {
  source = "./modules/eks"

  cluster_name       = var.cluster_name
  cluster_version    = var.cluster_version
  vpc_id             = data.terraform_remote_state.vpc.outputs.vpc_id
  private_subnet_ids = data.terraform_remote_state.vpc.outputs.private_subnet_ids
  fargate_namespaces = var.fargate_namespaces
  default_tags       = var.default_tags
}
