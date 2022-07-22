module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.13.0"

  name               = "ingress-nginx-vpc"
  cidr               = "10.0.0.0/16"
  azs                = ["eu-central-1a", "eu-central-1b"]
  public_subnets     = ["10.0.101.0/24", "10.0.102.0/24"]
  enable_nat_gateway = true
}

module "eks_cluster" {
  source  = "cloudposse/eks-cluster/aws"
  version = "0.45.0"

  region     = "eu-central-1"
  subnet_ids = module.vpc.public_subnets
  vpc_id     = module.vpc.vpc_id
  name       = "ingress-nginx"
}

module "eks_node_group" {
  source  = "cloudposse/eks-node-group/aws"
  version = "0.28.0"

  cluster_name   = "lb_controller"
  instance_types = ["t3.medium"]
  subnet_ids     = module.vpc.public_subnets
  min_size       = 1
  desired_size   = 1
  max_size       = 2
  depends_on     = [module.eks_cluster.kubernetes_config_map_id]
}

module "ingress_nginx_disabled" {
  source = "../../"

  enabled = false
}

module "ingress_nginx_helm" {
  source = "../../"

  enabled           = true
  argo_enabled      = false
  argo_helm_enabled = false

  helm_release_name = "ingress-nginx-helm"
  namespace         = "ingress-nginx-helm"

  values = yamlencode({
    "podLabels" : {
      "app" : "ingress-nginx-helm"
    }
  })

  helm_timeout = 240
  helm_wait    = true
}

module "ingress_nginx_argo_kubernetes" {
  source = "../../"

  enabled           = true
  argo_enabled      = true
  argo_helm_enabled = false

  helm_release_name = "ingress-nginx-argo-kubernetes"
  namespace         = "ingress-nginx-argo-kubernetes"

  argo_sync_policy = {
    "automated" : {}
    "syncOptions" = ["CreateNamespace=true"]
  }
}

module "ingress_nginx_argo_helm" {
  source = "../../"

  enabled           = true
  argo_enabled      = true
  argo_helm_enabled = true

  helm_release_name = "ingress-nginx-argo-helm"
  namespace         = "ingress-nginx-argo-helm"

  argo_namespace = "argo"
  argo_sync_policy = {
    "automated" : {}
    "syncOptions" = ["CreateNamespace=true"]
  }
}
