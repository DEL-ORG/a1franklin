variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "common_tags" {
  type = map(any)
  default = {
    "id"             = "9999"
    "owner"          = "gymef"
    "teams"          = "gym"
    "environment"    = "dev"
    "project"        = "aurora-postgres"
    "create_by"      = "gym-Terraform"
    "cloud_provider" = "aws"
  }
}

