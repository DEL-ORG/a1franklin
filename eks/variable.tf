variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "project_name" {
  type    = string
  default = "eks-cluster"
}


# Assuming you already have subnet IDs, you can define them as variables
variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
  default     = [""]
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
  default     = [""]
}















variable "common_tags" {
  type = map(any)
  default = {
    "id"             = "1000"
    "owner"          = "gymef"
    "teams"          = "gym"
    "environment"    = "dev"
    "project"        = "eks"
    "create_by"      = "gym-Terraform"
    "cloud_provider" = "aws"
  }
}
