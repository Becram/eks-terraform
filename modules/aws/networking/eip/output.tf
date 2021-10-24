output "ids" {
  value = aws_eip.default[*].id
}
output "ips" {
  value = aws_eip.default[*].public_ip
}

output "eip_allocations" {
  value = aws_eip.default[*].allocation_id
}
