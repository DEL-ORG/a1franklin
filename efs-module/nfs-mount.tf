# # Provisioning tasks for each instance
# resource "null_resource" "provision_instance" {
#   for_each = {
#     for id, instance in aws_instance.ec2 : instance.tags["Name"] => instance
#   }

#   # SSH into the instance and execute commands
#   provisioner "remote-exec" {
#     inline = [
#       # Create instance-specific folders
#       "if [ \"${self.triggers.name}\" == \"EC2-Instance-1\" ]; then sudo mkdir -p /mnt/efs/demo-test1; fi",
#       "if [ \"${self.triggers.name}\" == \"EC2-Instance-2\" ]; then sudo mkdir -p /mnt/efs/demo-test2; fi",

#       # Mount EFS to the created folder
#       "if [ \"${self.triggers.name}\" == \"EC2-Instance-1\" ]; then sudo mount -t nfs4 -o nfsvers=4.1 ${aws_efs_file_system.efs-demo.id}.efs.${var.aws_region}.amazonaws.com:/ /mnt/efs/demo-test1; fi",
#       "if [ \"${self.triggers.name}\" == \"EC2-Instance-2\" ]; then sudo mount -t nfs4 -o nfsvers=4.1 ${aws_efs_file_system.efs-demo.id}.efs.${var.aws_region}.amazonaws.com:/ /mnt/efs/demo-test2; fi",

#       # Add the mount to /etc/fstab
#       "if [ \"${self.triggers.name}\" == \"EC2-Instance-1\" ]; then echo '${aws_efs_file_system.efs-demo.id}.efs.${var.aws_region}.amazonaws.com:/ /mnt/efs/demo-test1 nfs4 defaults,_netdev 0 0' | sudo tee -a /etc/fstab; fi",
#       "if [ \"${self.triggers.name}\" == \"EC2-Instance-2\" ]; then echo '${aws_efs_file_system.efs-demo.id}.efs.${var.aws_region}.amazonaws.com:/ /mnt/efs/demo-test2 nfs4 defaults,_netdev 0 0' | sudo tee -a /etc/fstab; fi"
#     ]

#     connection {
#       type        = "ssh"
#       host        = each.value.public_ip
#       user        = "ec2-user"                        # Update this if using a different AMI
#       private_key = file("C:/Users/senyo/Downloads/Downloads/nfs-client-key.pem")
#     }
#   }

#   triggers = {
#     name = each.key
#   }

#   depends_on = [aws_instance.ec2]
# }


resource "null_resource" "provision_instance" {
  for_each = {
    for id, instance in aws_instance.ec2 : instance.tags["Name"] => instance
  }

  provisioner "remote-exec" {
    inline = [
      # Create instance-specific folders
      "if [ \"${each.key}\" == \"EC2-Instance-1\" ]; then sudo mkdir -p /mnt/efs/demo-test1; fi",
      "if [ \"${each.key}\" == \"EC2-Instance-2\" ]; then sudo mkdir -p /mnt/efs/demo-test2; fi",

      # Mount EFS to the created folder
      "if [ \"${each.key}\" == \"EC2-Instance-1\" ]; then sudo mount -t nfs4 -o nfsvers=4.1 ${aws_efs_file_system.efs-demo.id}.efs.${var.aws_region}.amazonaws.com:/ /mnt/efs/demo-test1; fi",
      "if [ \"${each.key}\" == \"EC2-Instance-2\" ]; then sudo mount -t nfs4 -o nfsvers=4.1 ${aws_efs_file_system.efs-demo.id}.efs.${var.aws_region}.amazonaws.com:/ /mnt/efs/demo-test2; fi",

      # Add the mount to /etc/fstab
      "if [ \"${each.key}\" == \"EC2-Instance-1\" ]; then echo '${aws_efs_file_system.efs-demo.id}.efs.${var.aws_region}.amazonaws.com:/ /mnt/efs/demo-test1 nfs4 defaults,_netdev 0 0' | sudo tee -a /etc/fstab; fi",
      "if [ \"${each.key}\" == \"EC2-Instance-2\" ]; then echo '${aws_efs_file_system.efs-demo.id}.efs.${var.aws_region}.amazonaws.com:/ /mnt/efs/demo-test2 nfs4 defaults,_netdev 0 0' | sudo tee -a /etc/fstab; fi"
    ]

    connection {
      type        = "ssh"
      host        = each.value.public_ip
      user        = "ec2-user"                        # Update this if using a different AMI
      private_key = file("C:/Users/senyo/Downloads/Downloads/nfs-client-key.pem")
    }
  }

  triggers = {
    name = each.key
  }

  depends_on = [aws_instance.ec2]
}

