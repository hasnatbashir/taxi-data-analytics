variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "Name tag for the VPC"
  type        = string
  default     = "primary_vpc"
}

variable "gateway_name" {
  description = "Name tag for the internet gateway"
  type        = string
  default     = "primary_gateway"
}

variable "sg_name" {
  description = "Name for the security group"
  type        = string
  default     = "primary_sg"
}

variable "subnet_cidr" {
  description = "CIDR block for the primary subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "subnet_name" {
  description = "Name tag for the primary subnet"
  type        = string
  default     = "primary_subnet"
}

variable "availability_zone" {
  description = "Availability Zone for the primary subnet"
  type        = string
  default     = "us-east-2a"
}

variable "route_table_name" {
  description = "Name tag for the route table"
  type        = string
  default     = "primary_route_table"
}

variable "ssh_key_pair_name" {
  description = "SSH Key-pair name"
  type        = string
  default     = "deployer-key"
}
