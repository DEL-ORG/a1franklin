aws_region = "us-east-1"
project_name = "eks-cluster"
eks-cluster = "gymef-eks-cluster"
eks-cluster-version = "1.28"
endpoint_private_access = false
endpoint_public_access = true
# gymef_subnet_id = ["subnet-12345678", "subnet-87654321"]

# List of public subnet IDs
# public_subnet_ids = [
#     "subnet-0b632a0db16d4bedd", 
#     "subnet-0a2445dd42a729270"]

# # List of private subnet IDs
# private_subnet_ids = [
#     "subnet-035a74e818848b722",
#     "subnet-0ec244561c1592740"]

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
