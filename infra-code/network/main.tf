resource "aws_vpc" "primary_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_internet_gateway" "primary_gateway" {
  vpc_id = aws_vpc.primary_vpc.id
  
  tags = {
    Name = var.gateway_name
  }
}

resource "aws_security_group" "primary_sg" {
  name   = var.sg_name
  vpc_id = aws_vpc.primary_vpc.id

  ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_subnet" "primary_subnet" {
  cidr_block        = var.subnet_cidr
  vpc_id            = aws_vpc.primary_vpc.id
  availability_zone = var.availability_zone

  tags = {
    Name = var.subnet_name
  }
}

resource "aws_route_table" "primary_route_table" {
  vpc_id = aws_vpc.primary_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.primary_gateway.id
  }

  tags = {
    Name = var.route_table_name
  }
}

resource "aws_route_table_association" "primary_subnet_association" {
  subnet_id      = aws_subnet.primary_subnet.id
  route_table_id = aws_route_table.primary_route_table.id
}

resource "aws_key_pair" "ssh_key_pair" {
  key_name   = "${var.ssh_key_pair_name}"
  public_key = file("~/.ssh/id_rsa.pub")
}
