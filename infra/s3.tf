resource "aws_s3_bucket" "website" {
  bucket = "infrawebsiteandrewchan"
  acl    = "public-read"
  
  versioning {
    enabled = true
  }

   tags = {
    Description = "bucket para guardar o tf state"
    EmailOwner  = "andrew.cm.sp@gmail.com"
    Owner  = "andrew"
   } 

}

resource "aws_s3_bucket_policy" "website" {
  bucket = aws_s3_bucket.website.id
  policy = data.aws_iam_policy_document.allow_public_access.json
}

data "aws_iam_policy_document" "allow_public_access" {
  statement {
    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject"
    ]

    resources = [
      "${aws_s3_bucket.website.arn}/*",
    ]
  }
}

resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.website.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_object" "index_page" {
  bucket       = aws_s3_bucket.website.id
  key          = "index.html"
  content_type = "text/html; charset=UTF-8"
  source       = "../src/index.html"
  etag         = filemd5("src/index.html")
}

resource "aws_s3_object" "error_page" {
  bucket       = aws_s3_bucket.website.id
  key          = "error.html"
  content_type = "text/html; charset=UTF-8"
  source       = "../src/error.html"
  etag         = filemd5("../src/error.html")
}


output "bucket_name" {
    value = aws_s3_bucket.state_terraform_aws.bucket
}

output "bucket_ARN" {
    value = aws_s3_bucket.state_terraform_aws.arn
}

output "url" {
  value = aws_s3_bucket_website_configuration.website.website_endpoint
}