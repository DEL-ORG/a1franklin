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
  region = "us-east-1"
}

provider "aws" {
  alias  = "backup-bucket"
  region =  "us-east-2"
}

module "s3_backend" {
  source = "github.com/DEL-ORG/a1franklin//s3-backend1"

  aws_region_main   = var.aws_region_main
  aws_region_backup = var.aws_region_backup
  env_type          = var.env_type
  project_name      = var.project_name
  common_tags       = var.common_tags
}
