module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name               = "ingress-nginx-vpc"
  cidr               = "10.0.0.0/16"
  azs                = ["eu-central-1a", "eu-central-1b"]
  public_subnets     = ["10.0.101.0/24", "10.0.102.0/24"]
  enable_nat_gateway = true
}

module "eks_cluster" {
  source = "cloudposse/eks-cluster/aws"

  region     = "eu-central-1"
  subnet_ids = module.vpc.public_subnets
  vpc_id     = module.vpc.vpc_id
  name       = "ingress-nginx"

  workers_security_group_ids = [module.eks_workers.security_group_id]
  workers_role_arns          = [module.eks_workers.workers_role_arn]
}

module "eks_workers" {
  source = "cloudposse/eks-workers/aws"

  cluster_certificate_authority_data = module.eks_cluster.eks_cluster_certificate_authority_data
  cluster_endpoint                   = module.eks_cluster.eks_cluster_endpoint
  cluster_name                       = "ingress-nginx"
  instance_type                      = "t3.medium"
  max_size                           = 1
  min_size                           = 1
  subnet_ids                         = module.vpc.public_subnets
  vpc_id                             = module.vpc.vpc_id

  associate_public_ip_address = true
}

# Use the module:

module "ingress_nginx" {
  source = "../../"

  settings = {
    # Examples:

    ## controller:
    ##   image:
    ##     tag: "v0.41.2"
    #
    # "controller.image.tag" = "v0.41.2"

    ## extraEnv:
    ## - name: var1
    ##   value: value1
    ## - name: var2
    ##   value: value2
    #
    ## "extraEnv[0].name"  = "var1"
    ## "extraEnv[0].value" = "value1"
    ## "extraEnv[1].name"  = "var2"
    ## "extraEnv[1].value" = "value2"

    ## extraEnv:
    ## - name: var3
    ##   valueFrom:
    ##     secretKeyRef:
    ##       name: existing-secret
    ##       key: varname3-key

    # "extraEnv[2].name" = "var3"
    # "extraEnv[2].valueFrom.secretKeyRef.name" = "existing-secret"
    # "extraEnv[2].valueFrom.secretKeyRef.key" = "varname3-key"
  }

}
