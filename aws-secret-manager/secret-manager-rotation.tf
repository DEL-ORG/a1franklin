resource "aws_secretsmanager_secret_rotation" "secret-rotation" {
  secret_id           = aws_secretsmanager_secret.gymef-secret.id
  rotation_lambda_arn = aws_lambda_function.test_lambda.arn

  rotation_rules {
    automatically_after_days = 30
  }
}






