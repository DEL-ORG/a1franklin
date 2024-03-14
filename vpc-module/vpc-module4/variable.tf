variable "custom_ami_id" {
  description = "Custom AMI ID. Leave empty to use the latest Ubuntu AMI."
  default     = ""
}

variable "aws_region" {
  type        = string
  description = "The AWS region where resources will be provisioned."
  default     = "us-east-1"
}

variable "common_tags" {
  type        = map(any)
  description = "Common tags to be applied to all resources."
  default = {
    "id"             = "2560"
    "owner"          = "DevOps Easy Learning"
    "teams"          = "DEL"
    "environment"    = "dev"
    "project"        = "del"
    "create_by"      = "Terraform"
    "cloud_provider" = "aws"
  }
}

variable "enable_dns_support" {
  type        = bool
  description = "Whether to enable DNS support for the VPC."
}

variable "enable_dns_hostnames" {
  type        = bool
  description = "Whether to enable DNS hostnames for the VPC."
}

variable "vpc_cidr_block" {
  type        = string
  description = "CIDR block for the VPC."
  default     = "10.0.0.0/16"
}

variable "aws_availability_zones" {
  type        = list(string)
  description = "List of availability zones to use."
  default = [
    "us-east-1a",
    "us-east-1b",
    "us-east-1c",
  ]
}

variable "environment" {
  type        = string
  description = "Environment name."
  default     = "dev"
}

variable "security_groups" {
  type        = list(string)
  description = "List of security group IDs."
  default     = ["sg-024cf8f69ed47f282"]
}
