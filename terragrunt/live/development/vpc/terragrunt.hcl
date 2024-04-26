terraform {
  source = "../../../../terraform-resources//vpc-only-02"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

inputs = {
  region                  = "us-east-1"
  enable_dns_support      = true
  enable_dns_hostnames    = true
  vpc_cidr_block          = "10.0.0.0/16"
  availability_zones      = ["us-east-1a", "us-east-1b", "us-east-1c"]

  common_tags = {
    "id"             = "2560"
    "owner"          = "DevOps Easy Learning"
    "teams"          = "DEL"
    "environment"    = "dev"
    "project"        = "del"
    "create_by"      = "Terraform"
    "cloud_provider" = "aws"
  }
}



