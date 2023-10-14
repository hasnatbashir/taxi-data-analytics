variable "region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-2"
}

variable "ssh_key_pair_name" {
  description = "SSH Key-pair name"
  type        = string
  default     = "deployer-key"
}
