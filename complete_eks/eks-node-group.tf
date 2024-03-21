# Resource: aws_iam_role
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role

# Create IAM role for EKS Node Group
resource "aws_iam_role" "gymef_node_aws_iam_role" {
  # The name of the role
  name = format("%s-gymef_node_aws_iam_role", var.common_tags["id"])

  # The policy that grants an entity permission to assume the role.
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      }, 
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

# Resource: aws_iam_role_policy_attachment
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment

resource "aws_iam_role_policy_attachment" "gymef_AmazonEKSWorkerNodePolicy" {
  # The ARN of the policy you want to apply.
  # https://github.com/SummitRoute/aws_managed_policies/blob/master/policies/AmazonEKSWorkerNodePolicy
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"

  # The role the policy should be applied to
  role = aws_iam_role.gymef_node_aws_iam_role.name
}

resource "aws_iam_role_policy_attachment" "gymef_AmazonEKS_CNI_Policy" {
  # The ARN of the policy you want to apply.
  # https://github.com/SummitRoute/aws_managed_policies/blob/master/policies/AmazonEKS_CNI_Policy
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"

  # The role the policy should be applied to
  role = aws_iam_role.gymef_node_aws_iam_role.name
}

resource "aws_iam_role_policy_attachment" "gymef_AmazonEC2ContainerRegistryReadOnly" {
  # The ARN of the policy you want to apply.
  # https://github.com/SummitRoute/aws_managed_policies/blob/master/policies/AmazonEC2ContainerRegistryReadOnly
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"

  # The role the policy should be applied to
  role = aws_iam_role.gymef_node_aws_iam_role.name
}

# Resource: aws_eks_node_group
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_node_group

resource "aws_eks_node_group" "nodes_general" {
  # Name of the EKS Cluster.
  cluster_name = var.eks-cluster

  # Name of the EKS Node Group.
   node_group_name = format("%s-gymef_eks-node-group", var.common_tags["id"])


  # Amazon Resource Name (ARN) of the IAM Role that provides permissions for the EKS Node Group.
  node_role_arn = aws_iam_role.gymef_node_aws_iam_role.arn

  # Identifiers of EC2 Subnets to associate with the EKS Node Group. 
  # These subnets must have the following resource tag: kubernetes.io/cluster/CLUSTER_NAME 
  # (where CLUSTER_NAME is replaced with the name of the EKS Cluster).
  subnet_ids = var.private_subnet_ids

  # Configuration block with scaling settings
  scaling_config {
    # Desired number of worker nodes.
    desired_size = 1

    # Maximum number of worker nodes.
    max_size = 1

    # Minimum number of worker nodes.
    min_size = 1 
  }

  # Type of Amazon Machine Image (AMI) associated with the EKS Node Group.
  # Valid values: AL2_x86_64, AL2_x86_64_GPU, AL2_ARM_64
  ami_type = "AL2_x86_64"

  # Type of capacity associated with the EKS Node Group. 
  # Valid values: ON_DEMAND, SPOT
  capacity_type = "ON_DEMAND"

  # Disk size in GiB for worker nodes
  disk_size = var.disk_size

  # Force version update if existing pods are unable to be drained due to a pod disruption budget issue.
  force_update_version = var.force_update_version

  # List of instance types associated with the EKS Node Group
  instance_types = ["t3.small"]
  labels = {
    role = "nodes_general"
  }


  # Kubernetes version
  version = var.eks-cluster-version

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.gymef_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.gymef_AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.gymef_AmazonEC2ContainerRegistryReadOnly,
  ]
}
