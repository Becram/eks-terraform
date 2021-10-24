output "region" {
  value = var.region
}
output "environment" {
  value = var.environment
}
output "account_id" {
  value = data.aws_caller_identity.current.account_id
}
output "cluster_name" {
  value = var.cluster_name
}
output "project_name" {
  value = var.project_name
}
