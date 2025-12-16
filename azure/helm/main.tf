module "hello_world_app" {
  source = "./modules/helm-chart"

  release_name     = "hello-world"
  chart_repository = "https://charts.softonic.io"
  chart_name       = "hello-world-app"
  namespace        = "default"

}

resource "kubernetes_manifest" "hello_world_ingress" {
  manifest = yamldecode(file("${path.module}/ingress.yaml"))

  depends_on = [
    module.hello_world_app
  ]
}
