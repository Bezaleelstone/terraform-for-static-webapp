resource "aws_s3_bucket" "terraform_bucket" {
  bucket = "praise-terraform-bucket"
  force_destroy = true
  
}

resource "aws_s3_object" "upload_website" {
  for_each = fileset("modules/s3_bucket/my_static_website_terraform/", "**/.")
  bucket = aws_s3_bucket.terraform_bucket.bucket
  key = each.value
  source = "modules/s3_bucket/my_static_website_terraform/${each.value}"
  content_type = lookup(
    {
      ".html" = "text/html"
      ".css"  = "text/css"
      ".js"   = "application/javascript"
    },
    regex("\\.[^.]*$", each.value),
    "application/octet-stream"
  )
}

resource "aws_s3_bucket_public_access_block" "website" {
  bucket = aws_s3_bucket.terraform_bucket.bucket

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
} 


# resource "aws_s3_bucket_policy" "bucket_policy" {
#   bucket = aws_s3_bucket.terraform_bucket.bucket
#   policy = data.aws_iam_policy_document.make_public.json
# }

# data "aws_iam_policy_document" "make_public" {
#   statement {
#     principals {
#       type        = "AWS"
#       identifiers = ["*"]
#     }

#     actions = [
#       "s3:GetObject",
#       "s3:ListBucket",
#     ]

#     resources = [
#       aws_s3_bucket.terraform_bucket.arn,
#       "${aws_s3_bucket.terraform_bucket.arn}/*",
#     ]
#   }
# }


# resource "aws_s3_bucket_website_configuration" "website" {
#     bucket = aws_s3_bucket.terraform_bucket.bucket
    
#     index_document {
#     suffix = "index.html"
#   }
#    error_document {
#     key = "error.html"
#   }
  
# }


# resource "aws_s3_bucket_policy" "website_bucket_policy" {
#   bucket = aws_s3_bucket.terraform_bucket.bucket

#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect: "Allow",
#         Principal: "*",
#         Action: "s3:GetObject",
#         Resource: "${aws_s3_bucket.terraform_bucket.arn}/*"
#       }
#     ]
#   })
# }


