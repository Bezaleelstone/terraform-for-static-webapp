output "bucket_endpoint" {
  description = "The website endpoint of the S3 bucket."
  value       = aws_s3_bucket.terraform_bucket.bucket_regional_domain_name
}

output "bucket_name" {
  description = "The name of the S3 bucket."
  value       = aws_s3_bucket.terraform_bucket.bucket
  
}

output "bucket_name_policy" {
  description = "The name policy of the S3 bucket."
  value       = aws_s3_bucket.terraform_bucket.arn
  
}

