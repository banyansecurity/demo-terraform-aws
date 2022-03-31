output "vpc_id" {
  description = "ID of project VPC"
  value       = aws_vpc.workshop_vpc.id
}

output "profile" {
  description = "AWS Profile"
  value       = var.aws_profile
}

output "private_subnet" {
  description = "Private Subnet"
  value       = aws_subnet.private_subnet.id
}

output "public_subnet" {
  description = "Public Subnet"
  value       = aws_subnet.public_subnet.id
}

output "private_network_security_group" {
  description = "Private Subnet Security Group"
  value       = aws_security_group.private_sg.id
}
