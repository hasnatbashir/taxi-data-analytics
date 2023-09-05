resource "aws_security_group" "ingress-all-test" {
name = "allow-all-sg"
vpc_id = "${aws_vpc.test-env.id}"
ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
from_port = 22
    to_port = 22
    protocol = "tcp"
  }
// Terraform removes the default rule
  egress {
   from_port = 0
   to_port = 0
   protocol = "-1"
   cidr_blocks = ["0.0.0.0/0"]
 }
}

resource "tls_private_key" "example" {
  algorithm = "RSA"
}

resource "aws_key_pair" "ssh_key" {
  key_name   = "${var.ami_key_pair_name}"
  public_key = file("~/.ssh/id_rsa.pub")
}