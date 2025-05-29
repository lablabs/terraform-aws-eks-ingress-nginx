/**
 * # AWS EKS Ingress Nginx Terraform module
 *
 * A Terraform module to deploy the ingress nginx on Amazon EKS cluster.
 *
 * [![Terraform validate](https://github.com/lablabs/terraform-aws-eks-ingress-nginx/actions/workflows/validate.yaml/badge.svg)](https://github.com/lablabs/terraform-aws-eks-ingress-nginx/actions/workflows/validate.yaml)
 * [![pre-commit](https://github.com/lablabs/terraform-aws-eks-ingress-nginx/actions/workflows/pre-commit.yaml/badge.svg)](https://github.com/lablabs/terraform-aws-eks-ingress-nginx/actions/workflows/pre-commit.yaml)
 */
locals {
  addon = {
    name = "ingress-nginx"

    helm_chart_name    = "ingress-nginx"
    helm_chart_version = "4.1.4"
    helm_repo_url      = "https://kubernetes.github.io/ingress-nginx"
  }

  addon_values = yamlencode({
    # FIXME config: add default values here
  })

  addon_depends_on = []
}
