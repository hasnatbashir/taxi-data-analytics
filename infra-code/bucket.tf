resource "aws_s3_bucket" "taxi-test-data-bucket" {
  bucket = "${var.bucket_name}"
  force_destroy = true
}