# resource "aws_iam_policy_attachment" "replication_policy_attachment" {
#   role    = aws_iam_role.replication_policy_attachment.name
#   policy_arn = aws_iam_policy.replication_policy_attachment.arn
# }

resource "aws_iam_role_policy_attachment" "replication_attachment" {
  role       = aws_iam_role.replication_role_main.name
  policy_arn = aws_iam_policy.replication_policy_main.arn
}

