variable "region" {
}
variable "environment" {
}
variable "vpc" {
  default     = "true"
  description = "https://www.terraform.io/docs/providers/aws/r/eip.html#vpc"
}
variable "eip_name" {
  default     = ""
  description = "Name of the IP"
}
variable "eip_count" {
  default     = 1
  description = "Determine how many IPs will be created"
}