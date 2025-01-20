# Use a data source to fetch the existing VPC
data "aws_vpc" "gymef-vpc" {
  filter {
    name   = "tag:Name"
    values = ["jenkins-vpc"] # Replace with your VPC name tag
  }
}

# Use a data source to fetch a subnet within the existing VPC
data "aws_subnet" "gymef-subnet" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.gymef-vpc.id]
  }

  filter {
    name   = "tag:Name"
    values = ["utrains default subnet"] # Replace with your Subnet name tag
  }
}