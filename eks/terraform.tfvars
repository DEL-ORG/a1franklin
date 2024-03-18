aws_region = "us-east-1"
project_name = "eks-cluster"

public_subnet_ids = ["subnet-0271bbde0398b033c", "subnet-0d1175dcfca0ddaa0", "subnet-03f53162d2b2b2347"]
private_subnet_ids = ["subnet-0126a7bddda993a7d", "subnet-029e854674db8ffc3", "subnet-0686a09f8fb681caa"]

common_tags = {
  id             = "1000"
  owner          = "gymef"
  teams          = "gym"
  environment    = "dev"
  project        = "eks"
  create_by      = "gym-Terraform"
  cloud_provider = "aws"
}
