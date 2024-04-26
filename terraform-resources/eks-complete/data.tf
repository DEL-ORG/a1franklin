data "aws_subnets" "private_subnets" {
  tags = {
    Name   = "2560-gymef_private_subnet-*"
  }
}

data "aws_subnets" "public_subnets" {
  tags = {
    Name   = "2560-gymef_public_subnet-*"
  }
}





# data "aws_vpc" "selected" {
#   filter {
#     name   = "tag:Name"
#     values = ["gymef-vpc"]  # Adjust this value to match your VPC name or tag
#   }
# }
