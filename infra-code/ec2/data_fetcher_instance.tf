resource "aws_instance" "data_fetcher_instance" {
  ami           = var.ami_id
  instance_type = "t2.micro"
  key_name      = var.ssh_key_pair_name
  security_groups = [var.primary_security_group_id]

  tags = {
    Name = "DataFetcherInstance"
    Role = "API to S3 Data Transfer"
  }

  subnet_id            = var.subnet_id
  iam_instance_profile = var.s3_instance_profile_name
}

resource "aws_eip" "primary_eip" {
    instance = aws_instance.data_fetcher_instance.id
}
