resource aws_vpc vg_vpc {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "vg_vpc"
  }
}
resource aws_internet_gateway igw {
  vpc_id = aws_vpc.vg_vpc.id
}
data aws_availability_zones vg_zones {
  state = "available"
}
resource aws_subnet public-subnets {
  count                   = length(var.public_subnets)
  vpc_id                  = aws_vpc.vg_vpc.id
  cidr_block              = element(var.public_subnets, count.index)
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.vg_zones.names[count.index]
  depends_on              = [aws_internet_gateway.igw]
  tags = {
    Name = "public_subnet_${count.index+1}"
  }
}
resource aws_subnet private-subnets {
  count                   = length(var.private_subnets)
  vpc_id                  = aws_vpc.vg_vpc.id
  cidr_block              = element(var.private_subnets, count.index)
  map_public_ip_on_launch = false
  availability_zone       = data.aws_availability_zones.vg_zones.names[count.index]
  tags = {
    Name = "private_subnet_${count.index+1}"
  }
}
resource aws_eip nat {
  count = length(var.public_subnets)
  vpc = true
}
resource aws_nat_gateway nat {
  depends_on    = [aws_internet_gateway.igw]
  count         = length(var.public_subnets)
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public-subnets[count.index].id
}
resource aws_route_table public {
  vpc_id = aws_vpc.vg_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "vg-main-public"
  }
}
resource aws_route_table_association public-subnets {
  count          = length(var.public_subnets)
  subnet_id      = element(aws_subnet.public-subnets.*.id, count.index)
  route_table_id = aws_route_table.public.id
}
resource aws_route_table private {
  vpc_id = aws_vpc.vg_vpc.id
  tags   = {
    Name = "vg-main-private"
  }
}
resource aws_route_table_association private-subnets {
  count = length(var.private_subnets)
  subnet_id = element(aws_subnet.private-subnets.*.id, count.index)
  route_table_id = aws_route_table.private.id
}
resource "aws_route" "private_default" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
  depends_on             = [aws_route_table.private]
}
resource aws_security_group vg_group {
  name = "vg_security_group"

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