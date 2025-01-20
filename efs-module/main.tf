

# Use a Security Group from the VPC or create a new one
resource "aws_security_group" "demo" {
  name        = "efs-sg1"
  vpc_id      = data.aws_vpc.gymef-vpc.id
  description = "Allow SSH and NFS traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create an Elastic File System (EFS)
resource "aws_efs_file_system" "efs-demo" {
  creation_token = "efs-demo"
  lifecycle_policy {
    transition_to_ia = "AFTER_30_DAYS"
  }
}

# Create EFS Mount Targets
resource "aws_efs_mount_target" "demo" {
  for_each        = toset([data.aws_subnet.gymef-subnet.id])
  file_system_id  = aws_efs_file_system.efs-demo.id
  subnet_id       = each.value
  security_groups = [aws_security_group.demo.id]
}



resource "aws_instance" "ec2" {
  count         = 2
  ami           = local.ami_id
  instance_type = local.instance_type
  key_name      = local.key_pair_name
  subnet_id     = data.aws_subnet.gymef-subnet.id
  security_groups = [
    aws_security_group.demo.id
  ]

  # User data to install NFS client and mount EFS
  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y amazon-efs-utils nfs-utils
    mkdir -p /mnt/efs
    echo "${aws_efs_file_system.efs-demo.id}.efs.${var.aws_region}.amazonaws.com:/ /mnt/efs nfs4 defaults,_netdev 0 0" >> /etc/fstab
    mount -a
  EOF

  # Combine global tags with resource-specific tags
  tags = merge(
    local.tags,
    { Name = "EC2-Instance-${count.index + 1}" }
  )
}




 