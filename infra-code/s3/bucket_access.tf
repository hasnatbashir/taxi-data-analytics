# IAM Role for EC2 to access S3
resource "aws_iam_role" "s3_access_role" {
  name = "S3AccessRoleForDataFetcher"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# IAM Policy to grant full access to the specific S3 bucket
resource "aws_iam_policy" "s3_data_bucket_access" {
  name        = "S3DataBucketFullAccess"
  description = "Grants full access to the data S3 bucket"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action   = ["s3:*"],
        Effect   = "Allow",
        Resource = [
          "arn:aws:s3:::${var.bucket_name}/*",
          "arn:aws:s3:::${var.bucket_name}"
        ]
      }
    ]
  })
}

# Attach the above policy to the IAM role
resource "aws_iam_role_policy_attachment" "s3_role_policy_attachment" {
  role       = aws_iam_role.s3_access_role.name
  policy_arn = aws_iam_policy.s3_data_bucket_access.arn
}

# Instance profile to be attached to the EC2 instance for S3 access
resource "aws_iam_instance_profile" "s3_instance_profile" {
  name = "S3AccessProfileForDataFetcher"
  role = aws_iam_role.s3_access_role.name
}
