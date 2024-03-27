resource "aws_secretsmanager_secret" "gymef-secret" {
  name = format("%s-gymef1-secret", var.common_tags["project"])
}

