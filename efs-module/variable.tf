variable "aws_region" {
  type    = string
  default = "us-east-1"

}

locals {
  ami_id             = "ami-0453ec754f44f9a4a"
  instance_type      = "t2.micro"
  key_pair_name      = "nfs-client-key"
  efs_creation_token = "efs-demo"
  vpc_id             = data.aws_vpc.gymef-vpc.id
  subnet_ids         = toset([data.aws_subnet.gymef-subnet.id])
  tags = {
    Env       = "Dev"
    Project   = "NFS-Demo"
    ManagedBy = "Terraform"
  }
}