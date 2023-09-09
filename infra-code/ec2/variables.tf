variable "ami_id" {
  type    = string
  default = "ami-0cf0e376c672104d6"
}

variable "key_pair_name" {
  type    = string
  default = "deployer-key"
}

variable "s3_instance_profile_name" {
  description = "IAM instance profile name for S3 access"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet where the EC2 instance should be deployed"
  type        = string
}

variable "primary_security_group_id" {
  description = "ID of security group for ec2 instance"
  type        = string
}

variable "ssh_key_pair_name" {
  description = "SSH Key-pair name"
  type        = string
  default     = "deployer-key"
}
