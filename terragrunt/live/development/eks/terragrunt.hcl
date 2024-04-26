terraform {
  source = "../../../../terraform-resources/eks-complete"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

dependencies {
  paths = [
    "${get_terragrunt_dir()}/../vpc", 
    ]
}


inputs = {
  cluster_name         = "gymef-eks-cluster"
  cluster_version      = "1.28"
  # vpc_id               = var.vpc_id
  subnets              = ["subnet-0b632a0db16d4bedd", "subnet-0a2445dd42a729270"]
  private_subnet_ids   = ["subnet-035a74e818848b722", "subnet-0ec244561c1592740"]
  node_groups = {
    "general" = {
      desired_capacity = 1
      max_capacity     = 5
      min_capacity     = 1
      instance_type    = "t3.medium"
    }
  }
  instance_types       = ["t3.small"]
  disk_size            = 20
  force_update_version = false

  tags = {
    id             = "4444"
    owner          = "gymef"
    teams          = "gym"
    environment    = "dev"
    project        = "eks"
    create_by      = "gym-Terraform"
    cloud_provider = "aws"
  }
}


