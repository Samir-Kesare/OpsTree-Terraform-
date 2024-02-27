/*--------------- VPC ---------------*/

resource "aws_vpc" "vpc-01" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = var.vpc_enable_dns_support
  enable_dns_hostnames = var.vpc_enable_dns_hostnames
  tags = var.vpc_tags
}

/*--------------- Public Subnets ---------------*/

resource "aws_subnet" "public_subnets" {
  count                   = length(var.public_subnets_cidr)
  vpc_id                  = aws_vpc.vpc-01.id
  cidr_block              = var.public_subnets_cidr[count.index]
  availability_zone       = var.public_subnets_az
  map_public_ip_on_launch = var.enable_map_public_ip_on_launch
  tags                    = var.public_subnets_tags[count.index]
}

/*--------------- Private Subnets ---------------*/

resource "aws_subnet" "private_subnets" {
  count             = length(var.private_subnets_cidr)
  vpc_id            = aws_vpc.vpc-01.id
  cidr_block        = var.private_subnets_cidr[count.index]
  availability_zone = var.private_subnets_az
  tags              = var.private_subnets_tags[count.index]
}

/*--------------- # Internet Gateway ---------------*/

resource "aws_internet_gateway" "dev_igw" {
  vpc_id = aws_vpc.vpc-01.id
  tags = var.igw_tags
}

/*--------------- Elastic IP ---------------*/

resource "aws_eip" "dev_elastic_ip" {
  domain = "vpc"
}

/*--------------- NAT Gateway ---------------*/

resource "aws_nat_gateway" "dev_nat" {
  allocation_id = aws_eip.dev_elastic_ip.id
  subnet_id     = aws_subnet.public_subnets[0].id
  tags = var.nat_tags
  depends_on = [aws_eip.dev_elastic_ip]
}
