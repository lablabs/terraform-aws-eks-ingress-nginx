data "aws_region" "current" {}

resource "helm_release" "self" {
  count = var.enabled ? 1 : 0

  repository = var.helm_repo_url
  chart      = var.helm_chart_name
  version    = var.helm_chart_version

  create_namespace = var.k8s_create_namespace
  namespace        = var.k8s_namespace
  name             = var.helm_release_name

  dynamic "set" {
    for_each = var.settings
    content {
      name  = set.key
      value = set.value
    }
  }

  depends_on = [var.mod_dependency]
}
