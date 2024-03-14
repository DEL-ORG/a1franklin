resource "aws_instance" "bastion_host" {
  ami           = "ami-07d9b9ddc6cd8dd30"  
  instance_type = "t2.micro"           
  key_name      = "jenkins-new"  
  # Specify security group IDs to attach to the bastion host
  vpc_security_group_ids = [
    aws_security_group.bastion-sg.id,
  ]
  # Specify the subnet ID where you want to deploy the bastion host
  subnet_id = aws_subnet.gymef_public_subnet[0].id  # Replace with your subnet ID

  # Automatically assign a public IP address to the bastion host
  associate_public_ip_address = true

  # Specify tags for the bastion host
  tags = merge(var.common_tags, {
    Name = "gymef_bastion_host"
  })
}
