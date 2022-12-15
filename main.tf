resource "aws_s3_bucket" "websitelaerte" {
  bucket = "websitelaerte"
}

resource "aws_s3_bucket_public_access_block" "websitelaerte" {
  bucket = aws_s3_bucket.websitelaerte.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_website_configuration" "websitelaerte" {
  bucket = aws_s3_bucket.websitelaerte.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}
resource "aws_s3_object" "object" {
  bucket = "websitelaerte"
  key    = "new_object_key"
  source = "./index.html"
}






