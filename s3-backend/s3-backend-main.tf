resource "aws_s3_bucket" "s3-backend-main" {
  provider = aws.main
  bucket   = format("%s-main", var.common_tags["id"])
  tags     = var.common_tags
}

resource "aws_s3_bucket_versioning" "s3-backend-main" {
  provider = aws.main
  bucket   = aws_s3_bucket.s3-backend-main.id
  versioning_configuration {
    status = "Enabled"
  }
}