# how to avoid exposing password in RDS database (aurora postgres)
master_password = var.master_password  # Use input variable here

variable "master_password" {
  description = "The master password for the RDS cluster"
  type        = string
  sensitive   = true
  # You can set a default value if needed
  # default     = "Pssw0rd123!"
}
# For example, you can set it via command-line flags:
terraform apply -var 'db_master_password=Pssw0rd123!'

# Or, you can set it via environment variables:
export TF_VAR_master_password=Pssw0rd123!
terraform apply