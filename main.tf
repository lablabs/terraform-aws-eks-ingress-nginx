locals {
  values = yamlencode({
    "awsRegion" : data.aws_region.current.name,
    "autoDiscovery" : {
      "clusterName" : var.cluster_name
    },
  })
}

data "aws_region" "current" {}

data "utils_deep_merge_yaml" "values" {
  count = var.enabled ? 1 : 0
  input = compact([
    local.values,
    var.values
  ])
}

resource "helm_release" "self" {
  count            = var.enabled ? 1 : 0
  chart            = var.helm_chart_name
  create_namespace = var.helm_create_namespace
  namespace        = var.k8s_namespace
  name             = var.helm_release_name
  version          = var.helm_chart_version
  repository       = var.helm_repo_url

  values = [
    data.utils_deep_merge_yaml.values[0].output
  ]

  dynamic "set" {
    for_each = var.settings
    content {
      name  = set.key
      value = set.value
    }
  }
}
