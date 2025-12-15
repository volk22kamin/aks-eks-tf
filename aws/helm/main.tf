# Reference cluster state from remote backend
data "terraform_remote_state" "cluster" {
  backend = "s3"

  config = {
    bucket  = var.cluster_state_bucket
    key     = var.cluster_state_key
    region  = var.region
    profile = var.aws_profile
  }
}

module "hello_world_app" {
  source = "./modules"

  release_name     = "hello-world"
  chart_repository = "https://charts.softonic.io"
  chart_name       = "hello-world-app"
  namespace        = "default"
  
}
