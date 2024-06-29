# resource "aws_iam_role" "user_for_terraform" {
#   name = "user_for_terraform"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Effect = "Allow",
#         Principal = {
#           Service = "ec2.amazonaws.com"
#         },
#         Action = "sts:AssumeRole"
#       }
#     ]
#   })
# }


# resource "aws_iam_policy" "s3_bucket_policy" {
#   name        = "S3BucketPolicy"
#   description = "Policy to allow S3 bucket and object actions"
#   policy      = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Effect = "Allow",
#         Action = [
#           "s3:CreateBucket",
#           "s3:DeleteBucket",
#           "s3:ListBucket",
#           "s3:GetBucketLocation",
#           "s3:PutBucketPolicy",
#           "s3:GetBucketPolicy",
#           "s3:DeleteBucketPolicy",
#           "s3:PutObject",
#           "s3:GetObject",
#           "s3:DeleteObject"
#         ],
#         Resource = [
#           "arn:aws:s3:::${aws_s3_bucket.terraform_bucket.bucket}",
#           "arn:aws:s3:::${aws_s3_bucket.terraform_bucket.bucket}/*"
#         ]
#       }
#     ]
#   })
# }

# resource "aws_iam_role_policy_attachment" "s3_bucket_policy_attachment" {
#   role       = aws_iam_role.user_for_terraform
#   policy_arn = aws_iam_policy.s3_bucket_policy.arn
# }