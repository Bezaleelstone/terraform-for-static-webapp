# module "s3_bucket" {
#   source = "../s3_bucket"
# }



# Create a CloudFront distribution
resource "aws_cloudfront_distribution" "cloudfront_static_website" {

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "CloudFront distribution with terraform for static webiste"
  default_root_object = "index.html"

  origin {
    domain_name = aws_s3_bucket.terraform_bucket.bucket_regional_domain_name
    origin_id   = "S3-terraform-bucket"
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path
    }
  }

  
  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-terraform-bucket"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
  cloudfront_default_certificate = true
  }
}

# Create a CloudFront origin access identity
resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  comment = "Origin Access Identity for terraform-bucket"
}

# Attach bucket policy to allow CloudFront access
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.terraform_bucket.bucket

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          AWS = aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn
        }
        Action = "s3:GetObject"
      Resource = [

        "${aws_s3_bucket.terraform_bucket.arn}/*"
        ]
      }
    ]
  })
}