terraform {
  backend "s3" {}
}

resource "aws_vpc_endpoint" "endpoint" {
  vpc_id            = var.vpc_id
  service_name      = var.service_name      #"com.amazonaws.ap-southeast-1.secretsmanager"
  vpc_endpoint_type = var.vpc_endpoint_type #"Interface"
  subnet_ids        = var.subnet_ids

  security_group_ids = [
    var.security_group_ids,
  ]

  private_dns_enabled = true
}
