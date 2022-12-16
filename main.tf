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
  bucket = aws_s3_bucket.websitelaerte.bucket
  key    = "index.html"
  source = "./index.html"
}

resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
  bucket = aws_s3_bucket.websitelaerte.id
  policy = data.aws_iam_policy_document.allow_access_from_another_account.json
}
data "aws_iam_policy_document" "allow_access_from_another_account" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["*"]
      }

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]

    resources = [
      aws_s3_bucket.websitelaerte.arn,
      "${aws_s3_bucket.websitelaerte.arn}/*",
    ]
  }
}

resource "aws_kms_key" "keyweb" {
  description             = "Encryption Bucket - websitelaerte"
  deletion_window_in_days = 7
}

resource "aws_s3_bucket_server_side_encryption_configuration" "websitelaerte" {
  bucket = aws_s3_bucket.websitelaerte.bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.keyweb.arn
      sse_algorithm     = "aws:kms"
    }
  }
}









