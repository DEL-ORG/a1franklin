data "aws_vpc" "vpc_id" {
  filter {
    name   = "tag:id"
    values = ["2560"]
  }

  filter {
    name   = "tag:project"
    values = ["del"]
  }
}

data "aws_subnet" "vpc_subnet_id" {
  filter {
    name   = "tag:Name"
    values = ["2560-gymef_public_subnet-2"]
  }

}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


data "aws_ami" "centos" {
  most_recent = true


  filter {
    name   = "name"
    values = ["tiov.it.CentOSLinuxrelease7.3.17823-e258d24f-5427-4f51-8c49-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}