resource "aws_s3_bucket" "data_bucket" {
  bucket = var.bucket_name
  force_destroy = false
}

resource "aws_s3_bucket_public_access_block" "data_bucket_access_block" {
  bucket = aws_s3_bucket.data_bucket.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls  = true
}
