output "ec2_public_ips" {
  value = aws_instance.ec2[*].public_ip
}



//output "ec2_public_ips" {
//  value = aws_instance.ec2[*].public_ip
//}

output "nfs_mount_command" {
  description = "Command to mount the EFS on an NFS client"
  value       = "sudo mount -t nfs4 ${aws_efs_file_system.efs-demo.id}.efs.${var.aws_region}.amazonaws.com:/ /mnt/efs"
}
