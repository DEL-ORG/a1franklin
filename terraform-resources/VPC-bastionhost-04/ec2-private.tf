# Create Ubuntu private EC2 instance
resource "aws_instance" "ec2_private" {
  count         = var.custom_ami_id != "" ? 0 : 1                                          # If custom AMI ID is provided, don't create this resource
  ami           = var.custom_ami_id != "" ? var.custom_ami_id : data.aws_ami.latest_ami.id # If custom AMI ID is provided, use it, else use the latest Ubuntu AMI
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.gymef_private_subnet[0].id
  key_name      = "jenkins-new"

  tags = merge(var.common_tags, {
    Name = "ec2_private"
  })

  security_groups = var.security_groups
}