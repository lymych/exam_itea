output "ec2_endpoint" {
  description = "The address of the EC2 instance"
  value       = aws_instance.ubuntu-exam.public_ip
}