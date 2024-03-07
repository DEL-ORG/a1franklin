output "public_subnet_id" {
  value = aws_subnet.gymef_public_subnet[*].id
}

output "private_subnet_id" {
  value = aws_subnet.gymef_private_subnet[*].id
}

output "vpc_id" {
  value = aws_vpc.gymef_vpc.id
}

output "security_group_id" {
  value = aws_security_group.bastion-sg.id
}

output "bastion_public_ip" {
  value = aws_instance.bastion_host.public_ip
}