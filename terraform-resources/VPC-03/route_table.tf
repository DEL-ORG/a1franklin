# Create Route Table for Private Subnets
resource "aws_route_table" "gymef_private_route_table" {
  vpc_id = aws_vpc.gymef_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.gymef_nat_gateway[0].id
  }

  tags = merge(var.common_tags, {
    Name = "${var.common_tags["id"]}-gymef_private_route_table"
  })
}

# Create Route Table for Public Subnets
resource "aws_route_table" "gymef_route_public" {
  vpc_id = aws_vpc.gymef_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gymef_igw.id
  }

  tags = merge(var.common_tags, {
    Name = "${var.common_tags["id"]}-gymef_route_public"
  })
}