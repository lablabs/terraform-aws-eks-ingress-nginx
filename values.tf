locals {
  values_default = yamlencode({
    "controller" : {
      "config" : {
        "proxy-body-size" : var.proxy_body_size
        "proxy-buffer-size" : var.proxy_buffer_size
      }
    }
  })
}

data "utils_deep_merge_yaml" "values" {
  count = var.enabled ? 1 : 0
  input = compact([
    local.values_default,
    var.values
  ])
}
