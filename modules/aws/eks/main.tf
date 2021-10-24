terraform {
  backend "s3" {}
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 17.0"

  cluster_name                          = var.cluster_name
  cluster_version                       = var.cluster_version
  cluster_endpoint_public_access        = var.cluster_endpoint_public_access
  cluster_endpoint_public_access_cidrs  = var.cluster_endpoint_public_access_cidrs
  cluster_endpoint_private_access       = var.cluster_endpoint_private_access
  cluster_endpoint_private_access_cidrs = var.cluster_endpoint_private_access_cidrs
  vpc_id                                = var.vpc_id
  subnets                               = var.vpc_private_subnets
  tags                                  = var.tags
  workers_additional_policies           = var.workers_additional_policies
  cluster_encryption_config             = var.cluster_encryption_config
  node_groups_defaults = merge(
    {
      key_name                  = var.aws_key_pair_key_name
      source_security_group_ids = [var.source_security_group_ids]

      subnets = slice(
        var.vpc_private_subnets,
        0,
        var.desired_capacity <= length(var.vpc_private_subnets) ? var.desired_capacity : length(var.vpc_private_subnets)
      ) # Must make number of assigned subnets <= number of desired nodes
    },
    var.node_groups_defaults
  )
  node_groups = merge(
//    {
//      template = merge(
//        {
//          launch_template_id      = var.aws_launch_template == true ? aws_launch_template.default[0].id : null
//          launch_template_version = var.aws_launch_template == true ? aws_launch_template.default[0].default_version : null
//        },
//        var.node_group_launch_template_defaults
//      )
//    },
    var.node_groups
  )
  map_roles        = var.map_roles
  map_users        = var.map_users
  map_accounts     = var.map_accounts
  write_kubeconfig = var.write_kubeconfig
  enable_irsa      = var.enable_irsa
}
