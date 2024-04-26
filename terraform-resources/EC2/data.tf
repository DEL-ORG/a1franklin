# Corrected data source type to aws_subnet
data "aws_subnet" "subnet_0" {
  filter {
    name   = "tag:Name"
    values = ["2560-gymef_public_subnet-0"]
  }
}

data "aws_subnet" "subnet_1" {
  filter {
    name   = "tag:Name"
    values = ["2560-gymef_public_subnet-1"]
  }
}

data "aws_subnet" "subnet_2" {
  filter {
    name   = "tag:Name"
    values = ["2560-gymef_public_subnet-2"]
  }
}

# Declare the vpc_id variable
variable "vpc_id" {
  type = string
  default = "vpc-0d716e9029037fd52"
}

# Ensure that the data block is placed correctly
data "aws_vpc" "selected" {
  id = var.vpc_id
}
