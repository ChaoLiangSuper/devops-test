locals {
  s3_origin_id = "myS3Origin"
  cfn_name = aws_cloudfront_distribution.cf_distribution.arn
}

resource "aws_cloudfront_origin_access_control" "origin_control" {
  name                              = "example"
  description                       = "Example Policy"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "cf_distribution" {

origin {
    domain_name              = aws_s3_bucket.www_bucket.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.origin_control.id
    origin_id                = local.s3_origin_id
  }
enabled             = true
default_root_object = "index.html"
aliases = [var.domain_name]

custom_error_response {
    error_caching_min_ttl = 0
    error_code            = 404
    response_code         = 200
    response_page_path    = "/index.html"
  }

restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

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
viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate_validation.validate.certificate_arn
    ssl_support_method       = "sni-only"
  }
tags = var.common_tags

}