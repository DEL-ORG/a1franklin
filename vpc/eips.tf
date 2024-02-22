resource "aws_eip" "gymef_eip" {
  count = length(var.aws_availability_zones)
  vpc   = true
  tags = merge(var.common_tags, {
    Name = format("%s-gymef_eip-${count.index}", var.common_tags["id"])
    },
  )
  depends_on = [aws_internet_gateway.gymef_igw]
}