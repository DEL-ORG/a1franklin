aws_region = "us-east-1"

subnet_ids = [
  "subnet-0ec8f617a33e20ec2",
  "subnet-0e4a88f795e88fd67"
]

security_group_id = "sg-03c77da029413afcd"

common_tags = {
  id             = "9999"
  owner          = "gymef"
  teams          = "gym"
  environment    = "dev"
  project        = "aurora-postgres"
  create_by      = "gym-Terraform"
  cloud_provider = "aws"
}
