/*--------------- VPC ---------------*/

resource "aws_vpc" "dev_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = var.vpc_enable_dns_support
  enable_dns_hostnames = var.vpc_enable_dns_hostnames
  tags = var.vpc_tags
}

/*--------------- Public Subnets ---------------*/

resource "aws_subnet" "dev_public_subnets" {
  count                   = length(var.public_subnets_cidr)
  vpc_id                  = aws_vpc.dev_vpc.id
  cidr_block              = var.public_subnets_cidr[count.index]
  availability_zone       = var.public_subnets_az[count.index]
  map_public_ip_on_launch = var.enable_map_public_ip_on_launch
  tags                    = var.public_subnets_tags[count.index]
}

/*--------------- Private Subnets ---------------*/

resource "aws_subnet" "dev_private_subnets" {
  count             = length(var.private_subnets_cidr)
  vpc_id            = aws_vpc.dev_vpc.id
  cidr_block        = var.private_subnets_cidr[count.index]
  availability_zone = var.private_subnets_az
  tags              = var.private_subnets_tags[count.index]
}

/*--------------- # Internet Gateway ---------------*/

resource "aws_internet_gateway" "dev_igw" {
  vpc_id = aws_vpc.dev_vpc.id
  tags = var.igw_tags
}

/*--------------- Elastic IP ---------------*/

resource "aws_eip" "dev_elastic_ip" {
  domain = "vpc"
}

/*--------------- NAT Gateway ---------------*/

resource "aws_nat_gateway" "dev_nat" {
  allocation_id = aws_eip.dev_elastic_ip.id
  subnet_id     = aws_subnet.dev_public_subnets[0].id
  tags = var.nat_tags
  depends_on = [aws_eip.dev_elastic_ip]
}

/*--------------- Public Route Table ---------------*/

resource "aws_route_table" "dev_public_rtb" {
  vpc_id = aws_vpc.dev_vpc.id
  route {
    cidr_block = var.vpc_cidr
    gateway_id = "local"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev_igw.id
  }
  tags = var.public_route_table_tags
}

/*--------------- Public RTB Association ---------------*/

resource "aws_route_table_association" "dev_public_route_association01" {
  count = length(aws_subnet.dev_public_subnets.*.id)
  subnet_id      = aws_subnet.dev_public_subnets[count.index].id
  route_table_id = aws_route_table.dev_public_rtb.id
}
/*--------------- Private RTB ---------------*/

resource "aws_route_table" "dev_private_rtb" {
  vpc_id = aws_vpc.dev_vpc.id
  route {
    cidr_block = var.vpc_cidr
    gateway_id = "local"
  }
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.dev_nat.id
  }
  tags = var.private_route_table_tags
  depends_on = [aws_nat_gateway.dev_nat]
}

/*--------------- Private RTB Association ---------------*/

resource "aws_route_table_association" "dev_private_route_association01" {

  count = length(aws_subnet.dev_private_subnets.*.id)
  subnet_id      = aws_subnet.dev_private_subnets[count.index].id
  route_table_id = aws_route_table.dev_private_rtb.id
  depends_on     = [aws_route_table.dev_private_rtb]
}

/*--------------- Frontend Subnet NACL ---------------*/

resource "aws_network_acl" "dev_frontend_nacl" {
  vpc_id = aws_vpc.dev_vpc.id

  dynamic "ingress" {
    for_each = var.frontend_nacl_ingress
    content {
      protocol   = ingress.value.protocol
      rule_no    = ingress.value.rule_no
      action     = ingress.value.action
      cidr_block = ingress.value.cidr_block
      from_port  = ingress.value.from_port
      to_port    = ingress.value.to_port
    }
  }
  dynamic "egress" {
    for_each = var.frontend_nacl_egress
    content {
      protocol   = egress.value.protocol
      rule_no    = egress.value.rule_no
      action     = egress.value.action
      cidr_block = egress.value.cidr_block
      from_port  = egress.value.from_port
      to_port    = egress.value.to_port
    }
  }
  tags = var.frontend_nacl_tags
}