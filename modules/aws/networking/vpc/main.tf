
module "vpc" {
  source                         = "terraform-aws-modules/vpc/aws"
  version                        = "~> 3.2.0"
  create_vpc                     = var.vpc.create_vpc
  name                           = var.vpc.name
  cidr                           = var.vpc.cidr
  azs                            = data.aws_availability_zones.available.names
  private_subnets                = var.vpc.private_subnets
  public_subnets                 = var.vpc.public_subnets
  database_subnets               = var.vpc.database_subnets
  manage_default_network_acl     = var.vpc.manage_default_network_acl
  public_dedicated_network_acl   = var.vpc.public_dedicated_network_acl
  public_inbound_acl_rules       = var.vpc.public_inbound_acl_rules
  public_outbound_acl_rules      = var.vpc.public_outbound_acl_rules
  private_dedicated_network_acl  = var.vpc.private_dedicated_network_acl
  private_inbound_acl_rules      = var.vpc.private_inbound_acl_rules
  private_outbound_acl_rules     = var.vpc.private_outbound_acl_rules
  database_dedicated_network_acl = var.vpc.database_dedicated_network_acl
  database_inbound_acl_rules     = var.vpc.database_inbound_acl_rules
  database_outbound_acl_rules    = var.vpc.database_outbound_acl_rules
  create_database_subnet_group   = var.vpc.create_database_subnet_group
  enable_dns_hostnames           = var.vpc.enable_dns_hostnames
  enable_dns_support             = var.vpc.enable_dns_support
  enable_nat_gateway             = var.vpc.enable_nat_gateway
  single_nat_gateway             = var.vpc.single_nat_gateway
  reuse_nat_ips                  = var.vpc.reuse_nat_ips
  external_nat_ip_ids            = var.vpc.external_nat_ip_ids
  one_nat_gateway_per_az         = var.one_nat_gateway_per_az
  tags                           = var.vpc.tags
  customer_gateways              = var.vpc.customer_gateways
  enable_vpn_gateway             = var.vpc.enable_vpn_gateway
  propagate_private_route_tables_vgw = var.vpc.propagate_private_route_tables_vgw

  private_subnet_tags = merge(
    {
      "kubernetes.io/cluster/${var.cluster_name}" = "shared"
      "kubernetes.io/role/internal-elb"           = "1"
      "SubnetType"                                = "Private"
    },
    var.private_subnet_extra_tags
  )
  public_subnet_tags = merge(
    {
      "kubernetes.io/cluster/${var.cluster_name}" = "shared"
      "kubernetes.io/role/elb"                    = "1"
      "SubnetType"                                = "Public"
    },
    var.public_subnet_extra_tags,
  )
}

resource "aws_default_network_acl" "default" {
  # no rules defined, deny all traffic in this ACL
  default_network_acl_id = module.vpc.default_network_acl_id
}

# TODO need to modify below to make it dynamic

resource "aws_route" "additional_private_route" {
  count                     = var.additional_public_route == true ? 1 : 0
  route_table_id            = module.vpc.private_route_table_ids[0]
  destination_cidr_block    = var.destination_route_cidr_block
  vpc_peering_connection_id = var.destination_route_resource
  depends_on                = [module.vpc]
}

resource "aws_route" "additional_public_route" {
  count                     = var.additional_public_route == true ? 1 : 0
  route_table_id            = module.vpc.public_route_table_ids[0]
  destination_cidr_block    = var.destination_route_cidr_block
  vpc_peering_connection_id = var.destination_route_resource
  depends_on                = [module.vpc]
}
