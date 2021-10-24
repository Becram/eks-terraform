variable "region" {
}
variable "environment" {
}
variable "cluster_name" {
  default = ""
}
variable "private_subnet_extra_tags" {
  description = "Extra tags to add to public subnets"
  type        = map(any)
  default     = {}
}
variable "public_subnet_extra_tags" {
  description = "Extra tags to add to private subnets"
  type        = map(any)
  default     = {}
}
variable "vpc" {
  default     = {}
  type        = any
  description = "https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws?tab=inputs"
}
variable "one_nat_gateway_per_az" {
  default     = true
  description = "If both single_nat_gateway and one_nat_gateway_per_az are set to true, then single_nat_gateway takes precedence."
}

variable "additional_public_route" {
  default = false
  type    = bool
}
variable "additional_private_route" {
  default = false
  type    = bool
}

variable "destination_route_resource" {
  default = "local"
  type    = string
}
variable "destination_route_cidr_block" {
  default = "10.0.0.0/16"
  type    = string
}
