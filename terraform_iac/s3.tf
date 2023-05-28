# S3 bucket for website.
resource "aws_s3_bucket" "www_bucket" {
  bucket = var.bucket_name
  
  
  tags = var.common_tags
}

resource "aws_s3_bucket_policy" "public_read_access" {
  bucket = aws_s3_bucket.www_bucket.id
  policy = templatefile("templates/s3-policy.json", { bucket = var.bucket_name, cfd = aws_cloudfront_distribution.cf_distribution.arn })
}