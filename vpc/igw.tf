resource "aws_internet_gateway" "gymef_igw" {
  depends_on = [
    aws_vpc.gymef_vpc
  ]
  vpc_id = aws_vpc.gymef_vpc.id
  tags = merge(var.common_tags, {
    Name = format("%s-gymef_igw", var.common_tags["id"])
    },
  )
}
