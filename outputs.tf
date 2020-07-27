output vpc_cidr_block {
  value       = aws_vpc.my_vpc.id
  sensitive   = true
  description = "VPC CIDR block"
}