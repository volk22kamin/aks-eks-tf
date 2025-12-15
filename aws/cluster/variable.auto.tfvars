region      = "eu-north-1"
aws_profile = "mend"
environment = "prod"

cluster_name    = "mend-eks-cluster"
cluster_version = "1.31"

vpc_state_bucket = "mend-state-739929374881"
vpc_state_key    = "vpc/terraform.tfstate"

alb_name = "hello-world-eks-alb"

fargate_namespaces = ["kube-system", "default"]

alb_security_group_ingress_rules = [
  {
    description = "Allow HTTP from internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    description = "Allow HTTPS from internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
]

alb_security_group_egress_rules = [
  {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
]

default_tags = {
  Environment = "prod"
  Project     = "mend"
  ManagedBy   = "Terraform"
}
