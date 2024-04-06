terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  backend "s3" {
    bucket         = "gymef-backend"
    dynamodb_table = "terrafrom-lock"
    key            = "LockID"
    region         = "us-east-1"
  }
}

provider "aws" {
  region = var.aws_region
  # Configuration options
}




