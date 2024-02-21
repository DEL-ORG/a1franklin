resource "aws_route_table" "gymef_route_public" {
  vpc_id = aws_vpc.gymef_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gymef_igw.id
  }
  tags = merge(var.common_tags, {
    Name = format("%s-gymef_route_public",var.common_tags["id"])
    },
  )
}


resource "aws_route_table" "gymef_route_private" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.gw1.id
  }
  tags = merge(var.common_tags, {
    Name = format("%s-gymef_route_private",var.common_tags["id"])
    },
  )
}

resource "aws_route_table" "gymef_route_private" {
  count                  = length(aws_availability_zones)
  vpc_id =  aws_vpc.gymef_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = element(aws_nat_gateway.gymef_nat_gateway.*.id, count.index)
  }
    tags = merge(var.common_tags, {
    Name = format("%s-gymef_route_private-${count.index}", var.common_tags["id"])
  })
  
}