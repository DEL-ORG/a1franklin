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
  default     = ["subnet-0271bbde0398b033c", "subnet-0d1175dcfca0ddaa0", "subnet-03f53162d2b2b2347"]
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
  default     = ["subnet-0126a7bddda993a7d", "subnet-029e854674db8ffc3", "subnet-0686a09f8fb681caa"]
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
