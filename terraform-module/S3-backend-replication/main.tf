# module
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  alias  = "main-bucket"
  region = local.aws_region_main
}

provider "aws" {
  alias  = "backup-bucket"
  region =  local.aws_region_backup
}

locals {
  aws_region_main = "us-east-1"
  aws_region_backup = "us-east-2"
  env_type = "dev"
  project_name = "a1project"

 common_tags = {
   "id"             = "4001"
   "owner"          = "gymef"
   "teams"          = "gym"
   "environment"    = "dev"
   "project"        = "s3-bucket"
   "create_by"      = "gym-Terraform"
   "cloud_provider" = "aws"
}
}

module "s3_backend" {
  source = "git@github.com:DEL-ORG/a1franklin.git//s3-backend1?ref=main"

  aws_region_main   = local.aws_region_main
  aws_region_backup = local.aws_region_backup
  env_type          = local.env_type
  project_name      = local.project_name
  common_tags       = local.common_tags
}
