resource "aws_s3_bucket_replication_configuration" "replication" {
  provider = aws.main

  depends_on = [
    aws_s3_bucket_versioning.s3-backend-main,
    aws_s3_bucket_versioning.backend-backup
  ]

  role   = aws_iam_role.replication_role_main.arn
  bucket = aws_s3_bucket.s3-backend-main.id

  rule {
    id       = "replicate-all-objects"
    status   = "Enabled"
    priority = 1

    destination {
      bucket        = aws_s3_bucket.backend-backup.arn
      storage_class = "STANDARD"
    }
    # delete_marker_replication {
    #   status = "Enabled"
    # }
  }
}