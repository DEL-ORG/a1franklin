# Launch an EC2 instance for Jenkins master
resource "aws_instance" "jenkins_master" {
  ami             = var.ami
  instance_type   = var.instance_type_master
  key_name        = var.key_name
  security_groups = [aws_security_group.gymef_jenkins_sg.name]
  user_data       = var.jenkins_user_data

  tags = {
    Name = "jenkins-master"
  }

  # Provision Jenkins on the master instance
  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install -y default-jre",
      "sudo apt install -y wget",
      "wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -",
      "sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'",
      "sudo apt update",
      "sudo apt install -y jenkins",
      "sudo systemctl start jenkins"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu" # or whatever user is appropriate for your AMI
      private_key = file(var.private_key_path) # path to your private key file
      host        = self.public_ip # use "self" to refer to the instance itself
    }
  }
}

# Launch an EC2 instance for Jenkins dynamic node
resource "aws_instance" "jenkins_node" {
  ami             = var.ami
  instance_type   = var.instance_type_node
  key_name        = var.key_name
  security_groups = [aws_security_group.gymef_jenkins_sg.name]
  user_data       = var.jenkins_user_data

  tags = {
    Name = "jenkins-node"
  }
}