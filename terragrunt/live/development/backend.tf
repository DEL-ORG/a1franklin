# Generated by Terragrunt. Sig: nIlQXj57tbuaRZEa
terraform {
  backend "s3" {
    bucket         = "3008-dev-del-tf-state"
    dynamodb_table = "3008-dev-del-tf-state-lock"
    encrypt        = true
    key            = "./terraform.tfstate"
    region         = "us-east-1"
  }
}
