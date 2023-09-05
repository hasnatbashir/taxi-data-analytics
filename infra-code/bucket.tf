resource "aws_s3_bucket" "taxi-test-data-bucket" {
  bucket = "taxi-test-data-bucket"
  force_destroy = true
}

resource "aws_s3_bucket_public_access_block" "taxi_test_data_bucket_access" {
  bucket = aws_s3_bucket.taxi-test-data-bucket.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls  = true
}

resource "aws_iam_policy" "bucket_policy" {
  name        = "my-bucket-policy"
  path        = "/"
  description = "Allow "

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "VisualEditor0",
        "Effect" : "Allow",
        "Action" : [
          "s3:PutObject",
          "s3:GetObject",
          "s3:ListBucket",
          "s3:DeleteObject"
        ],
        "Resource" : [
          "arn:aws:s3:::*/*",
          "arn:aws:s3:::taxi-test-data-bucket"
        ]
      }
    ]
  })
}