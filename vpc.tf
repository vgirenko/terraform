resource aws_vpc my_vpc {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "my_vpc"
  }
}
resource aws_internet_gateway igw {
  vpc_id = aws_vpc.my_vpc.id
}
data aws_availability_zones my_zones {
  state = "available"
}
resource aws_subnet public-subnets {
  count                   = length(var.public_subnets)
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = element(var.public_subnets, count.index)
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.my_zones.names[0]
  depends_on              = [aws_internet_gateway.igw]
}
resource aws_subnet private-subnets {
  count                   = length(var.private_subnets)
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = element(var.private_subnets, count.index)
  map_public_ip_on_launch = false
  availability_zone       = data.aws_availability_zones.my_zones.names[1]
}
resource aws_route_table public {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}
resource aws_route_table_association public-subnets {
  count          = length(var.public_subnets)
  subnet_id      = element(aws_subnet.public-subnets.*.id, count.index)
  route_table_id = aws_route_table.public.id
}
resource aws_security_group my_group {
  name = "my_security_group"

  dynamic "ingress" {
    for_each = var.ingress_ports
    content {
      from_port = ingress.value
      to_port   = ingress.value
      protocol  = "tcp"
    }
  }
  dynamic "egress" {
    for_each = var.egress_ports
    content {
      from_port = egress.value
      to_port   = egress.value
      protocol  = "tcp"
    }
  }
}