
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = local.region
}

locals {
  region = "us-east-1"

  tags =  {
    "id"             = "1300"
    "owner"          = "Practical DevOps"
    "teams"          = "PD"
    "environment"    = "dev"
    "project"        = "S3 Backend"
    "create_by"      = "Terraform"
    "cloud_provider" = "aws"
}

cidr = "10.0.0.0/16"

availability_zone = [
    "us-east-1a",
    "us-east-1b",
    "us-east-1c",
]

num_nat_gw = 1

}

module "vpc" {
  source = "git@github.com:DEL-ORG/a1angel-projects.git//terraform/modules/vpc-module?ref=main"
  //source = "../../modules/vpc-module/"
  region = local.region
  tags = local.tags
  cidr = local.cidr
  availability_zone = local.availability_zone
  num_nat_gw = local.num_nat_gw
}