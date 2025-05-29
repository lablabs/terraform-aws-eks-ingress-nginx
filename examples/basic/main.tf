module "addon_installation_disabled" {
  source = "../../"

  enabled = false
}


module "addon_installation_helm" {
  source = "../../"

  enabled           = true
  argo_enabled      = false
  argo_helm_enabled = false

  helm_release_name = "ingress-nginx-helm"
  namespace         = "ingress-nginx-helm"

  values = yamlencode({
    # insert sample values here
    podLabels = {
      app = "ingress-nginx-helm"
    }
  })

  helm_timeout = 240
  helm_wait    = true
}

# Please, see README.md and Argo Kubernetes deployment method for implications of using Kubernetes installation method
module "addon_installation_argo_kubernetes" {
  source = "../../"

  enabled           = true
  argo_enabled      = true
  argo_helm_enabled = false

  argo_sync_policy = {
    automated   = {}
    syncOptions = ["CreateNamespace=true"]
  }
}

module "addon_installation_argo_helm" {
  source = "../../"

  enabled           = true
  argo_enabled      = true
  argo_helm_enabled = true

  argo_sync_policy = {
    automated   = {}
    syncOptions = ["CreateNamespace=true"]
  }
}
