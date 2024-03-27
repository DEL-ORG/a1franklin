resource "aws_secretsmanager_secret_version" "secret-version" {
  secret_id     = aws_secretsmanager_secret.gymef-secret.id
  secret_string = "Pratical"
}