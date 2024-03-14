aws_region = "us-east-1"

common_tags = {
  "id"             = "4444"
  "owner"          = "Gymef DevOps"
  "teams"          = "DEL"
  "environment"    = "prod"
  "project"        = "dev-vpc"
  "create_by"      = "Terraform"
  "cloud_provider" = "aws"
}

enable_dns_support = true

enable_dns_hostnames = true

vpc_cidr_block = "10.0.0.0/16"

aws_availability_zones = [
  "us-east-1a",
  "us-east-1b",
  "us-east-1c",
]

environment = "dev"
