resource "aws_iam_role" "replication_role_main" {
  name = format("%s-replication_role_main", var.common_tags["project"])

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          Service = ["s3.amazonaws.com"]
        },
        Action = ["sts:AssumeRole"]
      }
    ]
  })
}
