resource "aws_route_table_association" "gymef_public_rt_associate" {
  count          = length(var.aws_availability_zones)
  subnet_id      = element(aws_subnet.gymef_public_subnet.*.id, count.index)
  route_table_id = aws_route_table.gymef_route_public.id
}

resource "aws_route_table_association" "gymef_private_rt_associate" {
  count          = length(var.aws_availability_zones)
  subnet_id      = element(aws_subnet.gymef_private_subnet.*.id, count.index)
  route_table_id = element(aws_route_table.gymef_route_private.*.id, count.index)
}
