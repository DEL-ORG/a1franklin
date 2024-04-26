# Resource: aws_iam_role
resource "aws_iam_role" "gymef_node_aws_iam_role" {
  name = format("%s-gymef_node_aws_iam_role", var.common_tags["id"])

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [{
      "Effect": "Allow",
      "Principal": { "Service": "ec2.amazonaws.com" },
      "Action": "sts:AssumeRole"
    }]
  })
}

# Resource: aws_iam_role_policy_attachment
resource "aws_iam_role_policy_attachment" "gymef_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.gymef_node_aws_iam_role.name
}

resource "aws_iam_role_policy_attachment" "gymef_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.gymef_node_aws_iam_role.name
}

resource "aws_iam_role_policy_attachment" "gymef_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.gymef_node_aws_iam_role.name
}

# Resource: aws_eks_node_group
resource "aws_eks_node_group" "nodes_general" {
  cluster_name = var.eks-cluster
  node_group_name = format("%s-gymef_eks-node-group", var.common_tags["id"])
  node_role_arn = aws_iam_role.gymef_node_aws_iam_role.arn

  subnet_ids = data.aws_subnets.private_subnets.ids  # Updated subnet_ids to use aws_subnets

  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }

  ami_type             = "AL2_x86_64"
  capacity_type        = "ON_DEMAND"
  disk_size            = var.disk_size
  force_update_version = var.force_update_version
  instance_types       = var.instance_types
  version              = var.eks-cluster-version

  depends_on = [
    aws_iam_role_policy_attachment.gymef_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.gymef_AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.gymef_AmazonEC2ContainerRegistryReadOnly,
  ]
}



data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = ["gymef-vpc"]  # Adjust this value to match your VPC name or tag
  }
}

