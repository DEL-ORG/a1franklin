resource "aws_vpc" "gymef_vpc" {
  cidr_block           = var.vpc_cidr_block # Set your desired CIDR block for the VPC
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = merge(var.common_tags, {
    Name =" gymef_vpc"
  })
}
