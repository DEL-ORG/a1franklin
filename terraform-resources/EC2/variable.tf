variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "ami" {
  type    = string
  default = "ami-0c7217cdde317cfec"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "key_name" {
  type    = string
  default = "jenkins-new"
}

variable "vpc_security_group_ids" {
  type    = list(string)
  default = ["sg-0566a67f9114ad123"]
}

variable "subnet_id" {
  type    = string
  default = "subnet-0e4a88f795e88fd67"
}

variable "volume_size" {
  type    = string
  default = "8"
}

variable "tags" {
  type = map(any)
  default = {
    "id"             = "2560"
    "owner"          = "DevOps Easy Learning"
    "teams"          = "DEL"
    "environment"    = "dev"
    "project"        = "del"
    "create_by"      = "Terraform"
    "cloud_provider" = "aws"
  }
}
