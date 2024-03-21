resource "aws_iam_role" "gymef_eks_cluster_iam_role" {
  name               = format("%s-%s-gymef_eks_cluster_iam_role", var.common_tags["id"], var.common_tags["project"])
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "gymef_iam_role_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.gymef_eks_cluster_iam_role.name
}

resource "aws_eks_cluster" "gymef-eks-cluster" {
  name = var.eks-cluster

  role_arn = aws_iam_role.gymef_eks_cluster_iam_role.arn
  version  = var.eks-cluster-version

  vpc_config {
    endpoint_private_access = var.endpoint_private_access
    endpoint_public_access  = var.endpoint_public_access
    subnet_ids              = var.public_subnet_ids
  }
  depends_on = [
    aws_iam_role_policy_attachment.gymef_iam_role_policy_attachment
  ]
}