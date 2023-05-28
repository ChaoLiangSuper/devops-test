#!/bin/bash

# This file is used to simulating the CD process
cd ../terraform_iac
terraform init
terraform validate
terraform apply
#Upload build content to S3
aws s3 sync ../test-app/build s3://<s3_bucket_name>/