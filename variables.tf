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
  type        = map
}
variable private_subnets {
  description = "A map of availability zones to CIDR blocks, which will be set up as private subnets"
  type        = map
}
variable ingress_ports {
  description = "A list of service ports for ingress traffic"
  type        = list
}
variable egress_ports {
  description = "A list of service ports for egress traffic"
  type        = list
}