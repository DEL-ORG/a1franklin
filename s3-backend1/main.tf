resource "aws_iam_role" "replication" {
  provider = aws.main-bucket
  name     = format("%s-aws_iam_role_replication", var.common_tags["id"])

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "sts:AssumeRole",
        "Principal" : {
          "Service" : "s3.amazonaws.com"
        },
        "Effect" : "Allow",
        "Sid" : ""
      }
    ]
  })

  tags = var.common_tags
}

resource "aws_iam_policy" "replication" {
  provider = aws.main-bucket
  name     = format("%s-iam-role-policy-replication", var.common_tags["id"])
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : [
          "s3:GetReplicationConfiguration",
          "s3:ListBucket"
        ],
        "Effect" : "Allow",
        "Resource" : [
          aws_s3_bucket.main-bucket.arn
        ]
      },
      {
        "Action" : [
          "s3:GetObjectVersion",
          "s3:GetObjectVersionAcl"
        ],
        "Effect" : "Allow",
        "Resource" : [
          "${aws_s3_bucket.main-bucket.arn}/*"
        ]
      },
      {
        "Action" : [
          "s3:ReplicateObject",
          "s3:ReplicateDelete"
        ],
        "Effect" : "Allow",
        "Resource" : "${aws_s3_bucket.backup-bucket.arn}/*"
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "replication" {
  provider   = aws.main-bucket
  name       = format("%s-iam-role-attachment-replication", var.common_tags["id"])
  roles      = [aws_iam_role.replication.name]
  policy_arn = aws_iam_policy.replication.arn
}

resource "aws_s3_bucket" "main-bucket" {
  provider = "aws.main-bucket"
  bucket   = format("%s-main-bucket", var.common_tags["id"])
  acl      = "private"
  versioning {
    enabled = true
  }

  replication_configuration {
    role = aws_iam_role.replication.arn

    rules {
      id     = "StateReplicationAll"
      prefix = ""
      status = "Enabled"

      destination {
        bucket        = aws_s3_bucket.backup-bucket.arn
        storage_class = "STANDARD"
      }
    }
  }

  tags = var.common_tags
}

resource "aws_s3_bucket" "backup-bucket" {
  provider = "aws.backup-bucket"
  bucket   = format("%s-backup-bucket", var.common_tags["id"])
  versioning {
    enabled = true
  }

  tags = var.common_tags
}

resource "aws_dynamodb_table" "tf-state-lock" {
  provider       = aws.main-bucket
  name           = format("%s-dynamodb_table-tf-state-lock", var.common_tags["id"])
  hash_key       = "BEWARE"
  read_capacity  = 20
  write_capacity = 20

  attribute {
    name = "BEWARE"
    type = "S"
  }

  tags = var.common_tags
}
