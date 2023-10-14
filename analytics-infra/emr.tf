provider "aws" {
  region  = "us-west-1" # Update to your preferred AWS region
}

resource "aws_emr_cluster" "example" {
  name          = "example-emr-cluster"
  release_label = "emr-6.4.0"

  applications = ["Hadoop", "Hive", "Spark"] # Add/Remove applications based on your needs

  termination_protection = false

  master_instance_group {
    instance_type = "m4.large"
    instance_count = 1
  }

  core_instance_group {
    instance_type  = "m4.large"
    instance_count = 2
  }

  ec2_attributes {
    subnet_id                         = "subnet-xxxxxxxx" # Update with your subnet ID
    emr_managed_master_security_group = "sg-xxxxxxxx"     # Security group for master nodes
    emr_managed_slave_security_group  = "sg-yyyyyyyy"     # Security group for core nodes
  }

  configurations_json = <<-CONFIG
[
  {
    "Classification": "hadoop-env",
    "Configurations": [],
    "Properties": {}
  }
]
  CONFIG
}

resource "aws_security_group" "emr_master" {
  name   = "emr_master"
  vpc_id = "vpc-xxxxxxxx" # Update with your VPC ID
}

resource "aws_security_group" "emr_core" {
  name   = "emr_core"
  vpc_id = "vpc-xxxxxxxx" # Update with your VPC ID
}
