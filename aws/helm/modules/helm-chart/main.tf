resource "helm_release" "this" {
  name       = var.release_name
  repository = var.chart_repository
  chart      = var.chart_name
  version    = var.chart_version != "" ? var.chart_version : null
  namespace  = var.namespace

  atomic          = var.atomic
  cleanup_on_fail = var.cleanup_on_fail
  replace         = var.replace
  wait            = var.wait
  timeout         = var.timeout

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
