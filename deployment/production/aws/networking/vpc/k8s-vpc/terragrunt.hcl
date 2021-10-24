# deployments/app/dev/network/terragrunt.hcl
terraform {
  source = "../../../../../../modules/aws/networking/vpc"
}

include {
  path = find_in_parent_folders("root.hcl")
}


dependency "root" {
  config_path = "../../../root"
  mock_outputs = {
    cluster_name = "dummy_new"
    project_name = "dummy"
    environment = "dummy"
  }
}

dependency "nat_gateway_ips" {
  config_path = "../../eip/nat-gateway"
  mock_outputs = {
    ids = ["eipalloc-11111111111111111"]
  }
}

locals {
  vpc_cidr                  = "10.2.0.0/16"
  public_subnet_extra_tags  = {}
  private_subnet_extra_tags = {}
}

inputs = {
  cluster_name              = dependency.root.outputs.cluster_name
  public_subnet_extra_tags  = local.public_subnet_extra_tags
  private_subnet_extra_tags = local.private_subnet_extra_tags
  vpc = {
    create_vpc                   = true
    name                         = "k8s-vpc"
    cidr                         = local.vpc_cidr
    private_subnets              = ["10.2.1.0/24", "10.2.2.0/24", "10.2.3.0/24", "10.2.4.16/28", "10.2.4.32/28", "10.2.4.0/28", "10.2.5.0/24", "10.2.6.0/24", "10.2.7.0/24"]
    public_subnets               = ["10.2.11.0/24", "10.2.12.0/24", "10.2.13.0/24"]
    database_subnets             = ["10.2.21.0/24", "10.2.22.0/24", "10.2.23.0/24"]
    manage_default_network_acl   = false
    public_dedicated_network_acl = true
    public_inbound_acl_rules = [
      {
        rule_number = 100
        rule_action = "allow"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_block  = "0.0.0.0/0"
      },
    ]
    public_outbound_acl_rules = [
      {
        rule_number = 100
        rule_action = "allow"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_block  = "0.0.0.0/0"
      },
    ]

    private_dedicated_network_acl = true
    private_inbound_acl_rules = [
      {
        rule_number = 100
        rule_action = "allow"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_block  = "0.0.0.0/0"
      },
    ]
    private_outbound_acl_rules = [
      {
        rule_number = 100
        rule_action = "allow"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_block  = "0.0.0.0/0"
      },
    ]

    database_dedicated_network_acl = true
    database_inbound_acl_rules = [
      {
        rule_number = 100
        rule_action = "allow"
        from_port   = 5432
        to_port     = 5432
        protocol    = "tcp"
        cidr_block  = local.vpc_cidr
      },
    ]
    database_outbound_acl_rules = [
      {
        rule_number = 100
        rule_action = "allow"
        from_port   = 0
        to_port     = 65535
        protocol    = "tcp"
        cidr_block  = local.vpc_cidr
      },
    ]
    create_database_subnet_group       = true
    enable_dns_hostnames               = true
    enable_dns_support                 = true
    enable_nat_gateway                 = true
    single_nat_gateway                 = false
    reuse_nat_ips                      = true
    one_nat_gateway_per_az             = true
    external_nat_ip_ids                = dependency.nat_gateway_ips.outputs.ids
    enable_vpn_gateway                 = true
    propagate_private_route_tables_vgw = true
    customer_gateways = {
      GPS-Palo-Alto = {
        bgp_asn    = 65112
        ip_address = "91.194.24.21"
      }
      GPS-Palo-Alto-Static = {
        bgp_asn    = 65000
        ip_address = "91.194.24.21"
      }
      GPS-Palo-Alto-Static-DR = {
        bgp_asn    = 65000
        ip_address = "195.10.112.20"
      }
    }

    tags = {
      Owner                                                           = "${dependency.root.outputs.project_name}"
      Environment                                                     = "${dependency.root.outputs.environment}"
      "kubernetes.io/cluster/${dependency.root.outputs.cluster_name}" = "shared"
    }
  }
}
