# Custom AMI ID. Leave empty to use the latest Ubuntu AMI.
custom_ami_id = ""  
# The AWS region where resources will be provisioned.
aws_region = "us-east-1"  

common_tags = {
  "id"             = "2560"
  "owner"          = "DevOps Easy Learning"
  "teams"          = "DEL"
  "environment"    = "dev"
  "project"        = "del"
  "create_by"      = "Terraform"
  "cloud_provider" = "aws"
}

enable_dns_support = true  # Whether to enable DNS support for the VPC.

enable_dns_hostnames = true  # Whether to enable DNS hostnames for the VPC.

vpc_cidr_block = "10.0.0.0/16"  
aws_availability_zones = [
  "us-east-1a",
  "us-east-1b",
  "us-east-1c",
]  # List of availability zones to use.

environment = "dev"  # Environment name.

security_groups = [ "sg-08274124f283c3edc"]  # List of security group IDs.
