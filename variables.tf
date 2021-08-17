# ingress-nginx

variable "enabled" {
  type        = bool
  default     = true
  description = "Variable indicating whether deployment is enabled"
}

# Helm

variable "helm_create_namespace" {
  type        = bool
  default     = true
  description = "Create the namespace if it does not yet exist"
}

variable "helm_chart_name" {
  type        = string
  default     = "ingress-nginx"
  description = "Helm chart name to be installed"
}

variable "helm_chart_version" {
  type        = string
  default     = "3.35.0"
  description = "Version of the Helm chart"
}

variable "helm_release_name" {
  type        = string
  default     = "ingress-nginx"
  description = "Helm release name"
}

variable "helm_repo_url" {
  type        = string
  default     = "https://kubernetes.github.io/ingress-nginx"
  description = "Helm repository"
}

# K8s

variable "k8s_namespace" {
  type        = string
  default     = "ingress-controller"
  description = "The K8s namespace in which the ingress-nginx has been created"
}

variable "settings" {
  type        = map(any)
  default     = {}
  description = "Additional settings which will be passed to the Helm chart values, see https://artifacthub.io/packages/helm/ingress-nginx/ingress-nginx"
}

variable "cluster_name" {
  type        = string
  description = "The name of the cluster"
}

variable "values" {
  type        = string
  default     = ""
  description = "Additional yaml encoded values which will be passed to the Helm chart."
}
