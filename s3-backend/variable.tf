variable "aws_region_main" {
  type        = string
  default     = "us-east-1"
  description = "AWS region for the main bucket"
}

variable "aws_region_backup" {
  type        = string
  default     = "us-east-2"
  description = "AWS region for the backup bucket"
}

variable "common_tags" {
  type = map(any)
  default = {
    "id"             = "9999"
    "owner"          = "gymef"
    "teams"          = "gym"
    "environment"    = "dev"
    "project"        = "s3-backup"
    "create_by"      = "gym-Terraform"
    "cloud_provider" = "aws"
  }
}