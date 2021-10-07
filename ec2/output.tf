output "instance_public_dns" {
  description = "public_dns  of the EC2 instance"
  value       = aws_instance.venu.public_dns
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.venu.public_ip
}