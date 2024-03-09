resource "aws_s3_bucket" "backend-backup" {
  provider = aws.backup
  bucket   = format("%s-backend-backup", var.common_tags["project"])
  tags     = var.common_tags
}

resource "aws_s3_bucket_versioning" "backend-backup" {
  provider = aws.backup
  bucket   = aws_s3_bucket.backend-backup.id
  versioning_configuration {
    status = "Enabled"
  }
}