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
  source = "./modules/helm-chart"

  release_name     = "hello-world"
  chart_repository = "https://charts.softonic.io"
  chart_name       = "hello-world-app"
  namespace        = "default"

  set_values = {
    "ingress.enabled" = "false"
  }

  depends_on = [module.aws_load_balancer_controller]
}

module "aws_load_balancer_controller" {
  source = "./modules/helm-chart"

  release_name     = "aws-load-balancer-controller"
  chart_repository = "https://aws.github.io/eks-charts"
  chart_name       = "aws-load-balancer-controller"
  namespace        = "kube-system"

  values_files = [
    yamlencode({
      clusterName = data.terraform_remote_state.cluster.outputs.eks_cluster_id
      region      = var.region
      vpcId       = data.terraform_remote_state.cluster.outputs.vpc_id
      serviceAccount = {
        name = "aws-load-balancer-controller"
        annotations = {
          "eks.amazonaws.com/role-arn" = data.terraform_remote_state.cluster.outputs.aws_load_balancer_controller_role_arn
        }
      }
    })
  ]

  replace         = true
  cleanup_on_fail = true
  atomic          = true
}

resource "kubernetes_manifest" "hello_world_target_group_binding" {
  manifest = {
    apiVersion = "elbv2.k8s.aws/v1beta1"
    kind       = "TargetGroupBinding"
    metadata = {
      name      = "hello-world"
      namespace = "default"
    }
    spec = {
      targetGroupARN = data.terraform_remote_state.cluster.outputs.alb_hello_world_target_group_arn
      serviceRef = {
        name = "hello-world-hello-world-app"
        port = 80
      }
      networking = {
        ingress = [{
          from = [{
            ipBlock = { cidr = "0.0.0.0/0" }
          }]
          ports = [{
            protocol = "TCP"
            port     = 8080
          }]
        }]
      }
    }
  }

  depends_on = [
    module.aws_load_balancer_controller,
    module.hello_world_app
  ]
}
