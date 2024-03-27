resource "aws_lambda_permission" "lambda_permission" {
  statement_id  = "AllowSecretsManagerToInvokeLambda"
  action        = "lambda:InvokeFunction"
  function_name = "practical_lambda_function"
  principal     = "secretsmanager.amazonaws.com"
}
