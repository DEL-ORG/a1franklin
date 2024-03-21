variable "aws_region" {
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

# #######################################################################################################

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

# variable "eks_ami_type " {
#   type        = string
#   default     = "AL2_x86_64"
# }

# variable "capacity_type " {
#   type        = string
#   default     = "ON_DEMAND"
# }

# variable "desired_size" {
#   type        = number
#   default     = 1
# }

# variable "max_size " {
#   type        = number
#   default     = 1
# }

# variable "min_size " {
#   type        = number
#   default     = 1
# }

variable "disk_size" {
  type        = number
  default     = 20
}

variable "force_update_version" {
  type        = bool
  default     = false
}

# variable "instance_types " {
#   type        = list(string)
#   default     = ["t3.small"]
# }

variable "common_tags" {
  type = map(any)
  default = {
    "id"             = "4444"
    "owner"          = "gymef"
    "teams"          = "gym"
    "environment"    = "dev"
    "project"        = "eks"
    "create_by"      = "gym-Terraform"
    "cloud_provider" = "aws"
  }
}
