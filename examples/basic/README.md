# Basic example

The code in this example shows how to use the module with basic configuration and minimal set of other resources.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_eks_cluster"></a> [eks\_cluster](#module\_eks\_cluster) | cloudposse/eks-cluster/aws | 0.45.0 |
| <a name="module_eks_node_group"></a> [eks\_node\_group](#module\_eks\_node\_group) | cloudposse/eks-node-group/aws | 0.28.0 |
| <a name="module_ingress_nginx_argo_helm"></a> [ingress\_nginx\_argo\_helm](#module\_ingress\_nginx\_argo\_helm) | ../../ | n/a |
| <a name="module_ingress_nginx_argo_kubernetes"></a> [ingress\_nginx\_argo\_kubernetes](#module\_ingress\_nginx\_argo\_kubernetes) | ../../ | n/a |
| <a name="module_ingress_nginx_disabled"></a> [ingress\_nginx\_disabled](#module\_ingress\_nginx\_disabled) | ../../ | n/a |
| <a name="module_ingress_nginx_helm"></a> [ingress\_nginx\_helm](#module\_ingress\_nginx\_helm) | ../../ | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | 3.13.0 |

## Resources

| Name | Type |
|------|------|
| [aws_eks_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) | data source |
| [aws_eks_cluster_auth.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster_auth) | data source |

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
