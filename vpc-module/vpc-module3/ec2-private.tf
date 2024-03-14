resource "aws_instance" "ec2_private" {
  ami                    = "ami-07d9b9ddc6cd8dd30"  
  instance_type          = "t2.micro" 
  subnet_id              = "subnet-03980835ab6bb5d0d" 
  key_name               = "jenkins-new"

  tags = merge(var.common_tags, {
    Name = "ec2_private"
  })

  security_groups = ["sg-024cf8f69ed47f282"]
}
