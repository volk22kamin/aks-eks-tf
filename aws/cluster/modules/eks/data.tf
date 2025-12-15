data "aws_caller_identity" "current" {}

data "aws_partition" "current" {}

# Get the TLS certificate for OIDC provider
data "tls_certificate" "cluster" {
  url = aws_eks_cluster.this.identity[0].oidc[0].issuer
}
