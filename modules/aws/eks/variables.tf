variable "region" {
  description = "AWS Region to be used"
  type        = string
  default     = ""
}
variable "environment" {
  description = "Environment, choose from staging or production"
  type        = string
  default     = ""
}
variable "create_eks" {
  type        = bool
  description = "Controls if EKS resources should be created (it affects almost all resources)"
  default     = true
}
variable "cluster_name" {
  description = "Name of the EKS cluster. Also used as a prefix in names of related resources."
  type        = string
}
variable "cluster_version" {
  description = "Kubernetes version to use for the EKS cluster."
  type        = string
  default     = "1.15"
}
variable "cluster_endpoint_public_access" {
  type        = bool
  description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled"
  default     = true
}
variable "cluster_endpoint_public_access_cidrs" {
  description = "List of CIDR blocks which can access the Amazon EKS public API server endpoint."
  type        = list(string)
  default     = []
}
variable "cluster_endpoint_private_access" {
  type        = bool
  description = "Indicates whether or not the Amazon EKS private API server endpoint is enabled"
  default     = false
}
variable "cluster_endpoint_private_access_cidrs" {
  type        = list(string)
  description = "List of CIDR blocks which can access the Amazon EKS private API server endpoint, when public access is disabled"
  default     = []
}
variable "node_groups_defaults" {
  description = "Map of values to be applied to all node groups. See `node_groups` module's documentaton for more details"
  type        = any
  default     = {}
}
variable "node_groups" {
  description = "Map of map of node groups to create. See `node_groups` module's documentation for more details"
  type        = any
  default     = {}
}
variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}
variable "map_accounts" {
  description = "Additional AWS account numbers to add to the aws-auth configmap."
  type        = list(string)

  default = []
}
variable "map_roles" {
  description = "Additional IAM roles to add to the aws-auth configmap."
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))

  default = []
}
variable "map_users" {
  description = "Additional IAM users to add to the aws-auth configmap."
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))

  default = []
}
variable "write_kubeconfig" {
  description = "if set to true, this will write kubeconfig to file localy."
  type        = bool
  default     = false
}
variable "cluster_encryption_config" {
  description = "Configuration block with encryption configuration for the cluster. See examples/secrets_encryption/main.tf for example format"
  type = list(
    object(
      {
        provider_key_arn = string,
        resources        = list(string)
      }
    )
  )
  default = []
}
variable "manage_cluster_iam_resources" {
  type        = bool
  description = "Whether to let the module manage cluster IAM resources. If set to false, cluster_iam_role_name must be specified"
  default     = true
}
variable "enable_irsa" {
  type        = bool
  description = "Whether to create OpenID Connect Provider for EKS to enable IRSA"
  default     = false
}
variable "desired_capacity" {
  description = "Desired number of nodes"
  type        = number
  default     = 1
}
variable "vpc_id" {
  description = ""
  type        = string
  default     = ""
}
variable "vpc_private_subnets" {
  description = ""
  type        = list(string)
  default     = []
}
variable "source_security_group_ids" {
  description = ""
  type        = string
  default     = ""
}
variable "workers_additional_policies" {
  default     = []
  description = "Additional policies to be added to workers"
  type        = list(any)
}
variable "aws_key_pair_key_name" {
  default     = ""
  description = "Key name of the key pair that will be used to access EKS worker"
  type        = string
}
variable "eks_cluster_iam_role_arn" {
  default     = ""
  description = "Iam role created for EKS cluster"
}
variable "aws_launch_template" {
  default     = false
  description = "use aws_launch_template ?"
  type        = bool
}
variable "cluster_encryption_config_kms_id" {
  default     = ""
  description = "kms key id to encrypt volumes"
  type        = string
}
variable "node_group_launch_template_defaults" {
  type    = any
  default = {}
}

