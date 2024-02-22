resource "aws_instance" "vm" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [var.vpc_security_group_ids[0]] # Accessing the first element of the list
  subnet_id              = var.subnet_id

  root_block_device {
    volume_size = var.volume_size
  }

  tags = merge(var.tags, {
    Name = format("%s-%s-gymef_bastion-host", var.tags["id"], var.tags["environment"]) # Accessing the tags directly
  })
}
