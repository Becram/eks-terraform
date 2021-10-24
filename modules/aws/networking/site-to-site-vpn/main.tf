terraform {
  backend "s3" {}
}

resource "aws_vpn_connection" "vpn_connection" {

  vpn_gateway_id          = var.vpn.vpn_gateway_id
  customer_gateway_id     = var.vpn.customer_gateway_id
  type                    = "ipsec.1"
  local_ipv4_network_cidr = var.vpn.local_ipv4_network_cidr
  remote_ipv4_network_cidr = var.vpn.remote_ipv4_network_cidr
  tags                    = var.vpn.tags
  static_routes_only      = lookup(var.vpn, "static_routes_only", false)
}
