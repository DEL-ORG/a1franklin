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
  region = var.aws_region_main
}

provider "aws" {
  alias  = "backup-bucket"
  region = var.aws_region_backup
}