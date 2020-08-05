variable aws_region {
  type    = string
  default = "eu-west-1"
}
variable vpc_cidr_block {
  type        = string
  description = "VPC CIDR block"
}
variable public_subnets {
  description = "A map of availability zones to CIDR blocks, which will be set up as public subnets"
  type        = list
}
variable private_subnets {
  description = "A map of availability zones to CIDR blocks, which will be set up as private subnets"
  type        = list
}
variable ingress_ports {
  description = "A list of service ports for ingress traffic"
  type        = list
}
variable egress_ports {
  description = "A list of service ports for egress traffic"
  type        = list
}