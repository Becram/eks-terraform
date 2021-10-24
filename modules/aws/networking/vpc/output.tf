output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "vgw_id" {
  description = "VGW id"
  value       = module.vpc.vgw_id
}

output "cgw_ids" {
  description = "CGW id's"
  value       = module.vpc.cgw_ids
}

output "vpc_cidr" {
  description = "VPC CIDR Block"
  value       = module.vpc.vpc_cidr_block
}

output "vpc_name" {
  description = "Name of the VPC"
  value       = module.vpc.name
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.vpc.private_subnets
}

output "private_subnet_arns" {
  description = "List of ARNs of private subnets"
  value       = module.vpc.private_subnet_arns
}

output "private_subnets_cidr_blocks" {
  description = "List of cidr_blocks of private subnets"
  value       = module.vpc.private_subnets_cidr_blocks
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.vpc.public_subnets
}

output "public_subnet_arns" {
  description = "List of ARNs of public subnets"
  value       = module.vpc.public_subnet_arns
}

output "public_subnets_cidr_blocks" {
  description = "List of cidr_blocks of public subnets"
  value       = module.vpc.public_subnets_cidr_blocks
}

output "database_subnets" {
  description = "List of IDs of database subnets"
  value       = module.vpc.database_subnets
}

output "database_subnet_arns" {
  description = "List of ARNs of database subnets"
  value       = module.vpc.database_subnet_arns
}

output "database_subnets_cidr_blocks" {
  description = "List of cidr_blocks of database subnets"
  value       = module.vpc.database_subnets_cidr_blocks
}

output "database_subnet_group" {
  description = "ID of database subnet group"
  value       = module.vpc.database_subnet_group
}
//
//output "public_subnet_id_a" {
//  value = matchkeys(module.vpc.public_subnets, module.vpc.azs, ["${var.region}a"])
//}
//
//output "private_subnet_id_a" {
//  value = matchkeys(module.vpc.private_subnets, module.vpc.azs, ["${var.region}a"])
//}
//
//output "public_subnet_id_b" {
//  value = matchkeys(module.vpc.public_subnets, module.vpc.azs, ["${var.region}b"])
//}
//
//output "private_subnet_id_b" {
//  value = matchkeys(module.vpc.private_subnets, module.vpc.azs, ["${var.region}b"])
//}
//
//output "public_subnet_id_c" {
//  value = matchkeys(module.vpc.public_subnets, module.vpc.azs, ["${var.region}c"])
//}
//
//output "private_subnet_id_c" {
//  value = matchkeys(module.vpc.private_subnets, module.vpc.azs, ["${var.region}c"])
//}

output "default_security_group_id" {
  description = "The ID of the security group created by default on VPC creation"
  value       = module.vpc.default_security_group_id
}

output "route_table_id" {
  value = module.vpc.public_route_table_ids
}
