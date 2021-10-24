
resource "aws_eip" "default" {
  count = var.eip_count
  vpc   = var.vpc
  tags = {
    Name        = "${var.eip_name}-${count.index}"
    Environment = var.environment
  }
}
