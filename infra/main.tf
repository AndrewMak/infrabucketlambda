terraform {
     backend "s3" {}
}

provider "aws" {
    region = "us-east-1"
}


resource "aws_s3_bucket" "state_terraform_aws" {
  bucket = "infrawebsiteandrewchan"
  acl    = "private"
  
  versioning {
    enabled = true
  }

   tags = {
    Description = "bucket para guardar o tf state"
    EmailOwner  = "andrew.cm.sp@gmail.com"
    Owner  = "andrew"
   } 

}
output "bucket_name" {
    value = aws_s3_bucket.state_terraform_aws.bucket
}

output "bucket_ARN" {
    value = aws_s3_bucket.state_terraform_aws.arn
}