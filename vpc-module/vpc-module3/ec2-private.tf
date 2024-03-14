resource "aws_instance" "ec2_private" {
  ami                    = "ami-07d9b9ddc6cd8dd30"  
  instance_type          = "t2.micro" 
  subnet_id              = "subnet-04fe73a01b7eae814" 
  key_name               = "jenkins-new"

  tags = merge(var.common_tags, {
    Name = "ec2_private"
  })

  security_groups = var.security_groups
  
}
