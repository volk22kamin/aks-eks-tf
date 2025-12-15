resource "helm_release" "this" {
  name       = var.release_name
  repository = var.chart_repository
  chart      = var.chart_name
  version    = var.chart_version != "" ? var.chart_version : null
  namespace  = var.namespace

  create_namespace = var.create_namespace

  values = var.values_files

  dynamic "set" {
    for_each = var.set_values
    content {
      name  = set.key
      value = set.value
    }
  }
}
