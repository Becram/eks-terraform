variable "region" {
}
variable "environment" {
}
variable "security_group" {
  default     = {}
  type        = any
  description = "https://registry.terraform.io/modules/terraform-aws-modules/security-group/aws?tab=inputs"
}
