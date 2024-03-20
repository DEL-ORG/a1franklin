variable "region" {
  type    = string
  default = "us-east-1"
}

variable "project_name" {
  type    = string
  default = "eks-cluster"
}
variable "eks-cluster" {
  type    = string
  default = "gymef-eks-cluster"
}
variable "eks-cluster-version" {
  type    = string
  default = "1.28"
}
variable "endpoint_private_access" {
  type    = bool
  default = false
}
variable "endpoint_public_access" {
  type    = bool
  default = true
}
variable "gymef_subnet_id" {
  type    = list(string)
  default = [""]
}
# Assuming you already have subnet IDs, you can define them as variables
variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
  default     = [""]
}

variable "tags" {
  type = map(string)
  default = {
    "id"          = "9992"
    "owner"       = "a1franklin"
    "teams"       = "gymef-project"
    "environment" = "dev"
    "project"     = "eks-cluster"
    "create_by"   = "gym-Terraform"
  }

}