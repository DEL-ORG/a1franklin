# Nat gateway for 3 private subnets
resource "aws_nat_gateway" "gymef_nat_gateway" {
  count         = length(var.aws_availability_zones)
  allocation_id = element(aws_eip.gymef_eip.*.id, count.index)
  subnet_id     = element(aws_subnet.gymef_public_subnet.*.id, count.index)
  tags = merge(var.common_tags, {
    Name = format("%s-gymef_nat_gateway-${count.index}", var.common_tags["id"])
    },
  )
}
