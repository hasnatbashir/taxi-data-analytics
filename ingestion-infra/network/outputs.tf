output "primary_vpc_id" {
  description = "The ID of the primary VPC"
  value       = aws_vpc.primary_vpc.id
}

output "primary_subnet_id" {
  description = "The ID of the primary subnet"
  value       = aws_subnet.primary_subnet.id
}

output "primary_security_group_id" {
  description = "The ID of the primary security group"
  value       = aws_security_group.primary_sg.id
}

