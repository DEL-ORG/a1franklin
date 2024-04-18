# Associate Private Subnets with Route Table
resource "aws_route_table_association" "gymef_private_subnet_association" {
  count          = length(aws_subnet.gymef_private_subnet)
  subnet_id      = aws_subnet.gymef_private_subnet[count.index].id
  route_table_id = aws_route_table.gymef_private_route_table.id
}

# Associate Public Subnets with Route Table
resource "aws_route_table_association" "gymef_public_subnet_association" {
  count          = length(aws_subnet.gymef_public_subnet)
  subnet_id      = aws_subnet.gymef_public_subnet[count.index].id
  route_table_id = aws_route_table.gymef_route_public.id
}