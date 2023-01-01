provider "aws" {
    region = "us-east-1"
}


resource "aws_s3_bucket" "state_terraform_aws" {
  bucket = "andrew-state-terraform"
  acl    = "private"
  
  versioning {
    enabled = true
  }

   tags = {
    Description = "bucket para guardar o tf state"
   } 

}
output "bucket_name" {
    value = aws_s3_bucket.state_terraform_aws.bucket
}

output "bucket_ARN" {
    value = aws_s3_bucket.state_terraform_aws.arn
}