terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

resource "aws_s3_bucket" "example" {
  bucket = "dev-tf-test-bucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}