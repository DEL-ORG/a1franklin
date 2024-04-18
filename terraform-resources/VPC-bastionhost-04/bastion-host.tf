# Create Ubuntu bastion host
resource "aws_instance" "bastion_host" {
  count                 = var.custom_ami_id != "" ? 0 : 1               # If custom AMI ID is provided, don't create this resource
  ami                   = var.custom_ami_id != "" ? var.custom_ami_id : data.aws_ami.latest_ami.id # If custom AMI ID is provided, use it, else use the latest Ubuntu AMI
  instance_type         = "t2.micro"
  key_name              = "jenkins-new"
  subnet_id             = aws_subnet.gymef_public_subnet[0].id
  associate_public_ip_address = true
  tags = merge(var.common_tags, {
    Name = "gymef_bastion_host"
  })

  security_groups = var.security_groups
}
