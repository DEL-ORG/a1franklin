# Create Elastic IPs
resource "aws_eip" "gymef_eip" {
  count = local.num_nat_gateways
  vpc   = true
  tags = merge(var.common_tags, {
    Name = format("%s-gymef_eip-%02d", var.common_tags["id"], count.index + 1)
  })
  depends_on = [aws_internet_gateway.gymef_igw]
}