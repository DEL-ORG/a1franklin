# Launch an EC2 instance for Jenkins master
resource "aws_instance" "jenkins_master" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = var.instance_type
  key_name        = var.key_name
  security_groups = [aws_security_group.gymef_jenkins_sg.name]
  user_data       = file("jenkins-script.sh")
  tags = merge(var.common_tags, {
    Name = "jenkins-master"
  })
}