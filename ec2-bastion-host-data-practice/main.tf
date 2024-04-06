# Create Ubuntu bastion host
resource "aws_instance" "bastion_host" {
  ami                         = var.custom_ami_id != "" ? var.custom_ami_id : data.aws_ami.ubuntu.id # If custom AMI ID is provided, use it, else use the latest Ubuntu AMI
  instance_type               = "t2.micro"
  key_name                    = "jenkins-new"
  subnet_id                   = data.aws_subnet.vpc_subnet_id.id
  associate_public_ip_address = true
  tags = merge(var.common_tags, {
    Name = "gymef_bastion_host"
  })
  vpc_security_group_ids = [aws_security_group.bastion-sg1.id]
  //vpc_security_group_ids = [data.aws_security_group.ec2-sg.id]
}

