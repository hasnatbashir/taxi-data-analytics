output "iam_instance_profile_name" {
  description = "The name of the IAM instance profile created for S3 bucket access."
  value       = aws_iam_instance_profile.s3_instance_profile.name
}
