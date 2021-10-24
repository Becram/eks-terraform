terraform {
  backend "s3" {}
}

module "security_group" {
  source              = "terraform-aws-modules/security-group/aws"
  version             = "~> 4.3"
  name                = var.security_group.name
  description         = var.security_group.description
  vpc_id              = var.security_group.vpc_id
  ingress_rules       = var.security_group.ingress_rules
  ingress_cidr_blocks = var.security_group.ingress_cidr_blocks
  ingress_with_self   = var.security_group.ingress_with_self
  egress_rules        = var.security_group.egress_rules
  egress_cidr_blocks  = var.security_group.egress_cidr_blocks
  tags                = var.security_group.tags
}
