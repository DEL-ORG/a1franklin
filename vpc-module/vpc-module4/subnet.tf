# Create public subnets
resource "aws_subnet" "gymef_public_subnet" {
  count             = length(var.aws_availability_zones)
  vpc_id            = aws_vpc.gymef_vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr_block, 8, count.index)
  availability_zone = element(var.aws_availability_zones, count.index)

  tags = merge(var.common_tags, {
    Name = format("%s-gymef_public_subnet-${count.index}", var.common_tags["id"])
  })
}

# Create private subnets
resource "aws_subnet" "gymef_private_subnet" {
  count             = length(var.aws_availability_zones)
  vpc_id            = aws_vpc.gymef_vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr_block, 6, count.index + 1)
  availability_zone = element(var.aws_availability_zones, count.index)

  tags = merge(var.common_tags, {
    Name = format("%s-gymef_private_subnet-${count.index}", var.common_tags["id"])
  })
}
