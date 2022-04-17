output "vpc_id" {
  value       = aws_vpc._.id
}

output "public_subnet_id" {
  value       = aws_subnet.public.id
}

output "private_subnet_id" {
  value       = aws_subnet.private.id
}

output "private_2_subnet_id" {
  value       = aws_subnet.private_2.id
}

output "vpc_security_group_id" {
  value       = aws_security_group.vpc_sg.id
}