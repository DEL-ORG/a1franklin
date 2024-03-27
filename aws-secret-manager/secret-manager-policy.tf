data "aws_iam_policy_document" "secret_iam_policy" {
  statement {
    sid    = "EnableAnotherAWSAccountToReadTheSecret"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]  # Correcting the ARN to include "role/"
    }

    

    actions   = ["secretsmanager:GetSecretValue"]
    resources = ["*"]
  }
}

resource "aws_secretsmanager_secret_policy" "secretmanger_secret_policy" {
  secret_arn = aws_secretsmanager_secret.gymef-secret.arn
  policy     = data.aws_iam_policy_document.secret_iam_policy.json
}
