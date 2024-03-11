variable "aws_region_main" {
  type    = string
  default = "us-east-1"
}

variable "aws_region_backup" {
  type    = string
  default = "us-east-2"
}

variable "env_type" {
  type    = string
  default = "dev"
}

variable "project_name" {
  type    = string
  default = "a1project"
}

variable "common_tags" {
  type = map(any)
  default = {
    "id"             = "4001"
    "owner"          = "gymef"
    "teams"          = "gym"
    "environment"    = "dev"
    "project"        = "s3-bucket"
    "create_by"      = "gym-Terraform"
    "cloud_provider" = "aws"
  }
}
