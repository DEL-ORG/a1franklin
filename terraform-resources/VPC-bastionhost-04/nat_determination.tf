# Determine the number of NAT Gateways based on environment
locals {
  num_nat_gateways = var.environment == "dev" ? 1 : length(var.aws_availability_zones)
}