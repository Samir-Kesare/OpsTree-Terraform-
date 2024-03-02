output "vpc-id" {
  value = aws_vpc.dev_vpc.id
}

output "public-subnets-id" {
  value = aws_subnet.dev_public_subnets.*.id
}


output "private-subnets-id" {
  value = aws_subnet.dev_private_subnets.*.id
}

output "dev-igw-id" {
  value = aws_internet_gateway.dev_igw.id
}

output "dev-nat-id" {
  value = aws_nat_gateway.dev_nat.id
}

output "dev-public-RTB-id" {
  value = aws_route_table.dev_public_rtb.id
}

output "dev-private-RTB-id" {
  value = aws_route_table.dev_private_rtb.id
}

output "dev-frontend-nacl-id" {
  value = aws_network_acl.dev_frontend_nacl.id
}