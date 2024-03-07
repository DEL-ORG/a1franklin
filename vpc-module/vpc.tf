resource "aws_vpc" "gymef_vpc" {
  cidr_block         = var.vpc_cidr_block # Set your desired CIDR block for the VPC
  enable_dns_support = var.enable_dns_support


  tags = merge(var.common_tags, {
    Name = " gymef_vpc"
  })
}
