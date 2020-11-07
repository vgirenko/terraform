output vpc_id {
  value       = aws_vpc.vg_vpc.id
  sensitive   = false
  description = "VPC ID"
}