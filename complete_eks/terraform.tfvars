aws_region = "us-east-1"
project_name = "eks-cluster"
eks-cluster = "gymef-eks-cluster"
eks-cluster-version = "1.28"
endpoint_private_access = false
endpoint_public_access = true
# gymef_subnet_id = ["subnet-12345678", "subnet-87654321"]

# List of public subnet IDs
public_subnet_ids = [
    "subnet-0a8d58fa650f29002", 
    "subnet-04d2912aa21743466"]

# List of private subnet IDs
private_subnet_ids = [
    "subnet-0b8cb43a3fe28c0c0",
    "subnet-0785e6d5a77d94cb8"]

# Disk size in GiB for worker nodes
disk_size = 20

# Whether to force version update
force_update_version = false

# Common tags
common_tags = {
  id = "4444"
  owner = "gymef"
  teams = "gym"
  environment = "dev"
  project = "eks"
  create_by = "gym-Terraform"
  cloud_provider = "aws"
}
