vpc_cidr_block = "10.0.0.0/16"
public_subnets = {
  "eu-west-1a" = "10.0.1.0/24"
  "eu-west-1b" = "10.0.3.0/24"
}
private_subnets = {
  "eu-west-1a" = "10.0.2.0/24"
  "eu-west-1b" = "10.0.4.0/24"
}
ingress_ports = ["22", "80", "443"]
egress_ports  = ["80", "443"]