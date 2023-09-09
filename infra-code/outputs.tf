output "primary_vpc_id" {
  description = "ID of the primary VPC"
  value       = module.network.primary_vpc_id
}

output "data_fetcher_instance_public_ip" {
  description = "Public IP of the data fetcher EC2 instance"
  value       = module.data_fetcher_instance.public_ip_address
}