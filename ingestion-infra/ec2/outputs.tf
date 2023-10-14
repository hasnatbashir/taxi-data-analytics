output "public_ip_address" {
  description = "Elastic IP Address"
  value       = aws_eip.primary_eip.public_dns
}
