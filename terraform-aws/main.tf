

module "s3_bucket" {
  source = "./modules/s3_bucket"
  bucket_name = var.s3-bucket-name
}

module "cloudfront" {
  source             = "./modules/cloudfront"
}



# module "iam_module" {
#   source = "./modules/iam"
# }