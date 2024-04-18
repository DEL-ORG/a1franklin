# Determine the number of NAT Gateways based on environment
locals {
  num_nat_gateways = var.environment == "dev" ? 1 : length(var.aws_availability_zones)
}

# Create NAT Gateways
resource "aws_nat_gateway" "gymef_nat_gateway" {
  count         = local.num_nat_gateways
  allocation_id = aws_eip.gymef_eip[count.index].id
  subnet_id     = aws_subnet.gymef_public_subnet[count.index % length(aws_subnet.gymef_public_subnet)].id
  tags = merge(var.common_tags, {
    Name = format("%s-gymef_nat_gateway-%02d", var.common_tags["id"], count.index + 1)
  })
}
