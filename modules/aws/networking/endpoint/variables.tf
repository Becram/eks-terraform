variable "security_group_ids" {
  default = ""
}
variable "vpc_endpoint_type" {
  default = ""
  type    = string
}
variable "service_name" {
  default = ""
}
variable "vpc_id" {
  default = ""
}
variable "region" {
  default = ""
}
variable "subnet_ids" {
  type = any
}
