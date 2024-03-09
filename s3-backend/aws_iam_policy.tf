# resource "aws_iam_policy" "replication_policy_main" {
#   name = format("%s-replication_policy", var.common_tags["project"])

#   policy = jsonencode({
#     "Version" : "2012-10-17",
#     "Statement" : [
#       {
#         "Effect" : "Allow",
#         "Action" : [
#           "s3:GetReplicationConfiguration",
#           "s3:ListBucket",
#           "s3:GetBucketVersioning",
#           "s3:GetObjectVersionTagging",
#           "s3:GetObjectVersionTorrent",
#           "s3:GetObjectVersion",
#           "s3:PutBucketVersioning",
#           "s3:GetObjectVersionForReplication"
#         ],
#         "Resource" : ["${aws_s3_bucket.s3-backend-main.arn}/*"]
#       },
#       {
#         "Effect" : "Allow",
#         "Action" : [
#           "s3:ReplicateObject",
#           "s3:ReplicateDelete",
#           "s3:ReplicateTags",
#           "s3:ReplicateObjectTagging"
#         ],

#         Resources = ["${aws_s3_bucket.backend-backup.arn}/*"]
#       }
#     ]
#   })
# }




resource "aws_iam_policy" "replication_policy_main" {
  name = format("%s-replication_policy", var.common_tags["project"])

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "s3:GetReplicationConfiguration",
          "s3:ListBucket",
          "s3:GetBucketVersioning",
          "s3:GetObjectVersionTagging",
          "s3:GetObjectVersionTorrent",
          "s3:GetObjectVersion",
          "s3:PutBucketVersioning",
          "s3:GetObjectVersionForReplication"
        ],
        "Resource": ["${aws_s3_bucket.s3-backend-main.arn}/*"]
      },
      {
        "Effect": "Allow",
        "Action": [
          "s3:ReplicateObject",
          "s3:ReplicateDelete",
          "s3:ReplicateTags",
          "s3:ReplicateObjectTagging"
        ],
        "Resource": ["${aws_s3_bucket.backend-backup.arn}/*"]
      },
      {
        "Effect": "Allow",
        "Action": [
          "s3:GetBucketLocation",
          "s3:GetObject",
          "s3:ListBucket",
          "s3:ListBucketMultipartUploads",
          "s3:ListMultipartUploadParts",
          "s3:PutObject"
        ],
        "Resource": ["${aws_s3_bucket.backend-backup.arn}/*"],
        "Condition": {
          "StringEquals": {
            "s3:x-amz-acl": "bucket-owner-full-control"
          }
        }
      }
    ]
  })
}
