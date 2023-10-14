module "network" {
  source = "./network/"
  ssh_key_pair_name = var.ssh_key_pair_name

  # If you want to override any default values:
  # vpc_cidr = "10.0.0.0/16"
  # vpc_name = "my_custom_vpc_name"
  # ... other variables
}

module "s3_bucket" {
  source = "./s3/"
  
  # bucket_name can be overridden here, if required
  bucket_name = "my-tf-test-bucket-hasnat"
}

module "data_fetcher_instance" {
  source = "./ec2/"

  # Point the instance to the appropriate network resources
  subnet_id = module.network.primary_subnet_id
  s3_instance_profile_name = module.s3_bucket.iam_instance_profile_name
  primary_security_group_id = module.network.primary_security_group_id
  ssh_key_pair_name = var.ssh_key_pair_name

  # If you want to override any default values:
  # instance_type = "t2.micro"
  # ami_id        = "ami-0cf0e376c672104d6"
  # ... other variables
}
