data "aws_ami" "latest_ami" {
  most_recent = true
  owners      = ["529881641329"] # Your AWS account ID for Ubuntu AMIs
  filter {
    name   = "name"
    values = ["ubuntu*"] # Filter criteria for Ubuntu 20.04 LTS (Focal Fossa)
  }
}
