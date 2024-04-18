variable "backend" {
  type = map(string)
  default = {
    bucket         = ""
    dynamodb_table = ""
    key            = ""
    region         = ""
  }
}