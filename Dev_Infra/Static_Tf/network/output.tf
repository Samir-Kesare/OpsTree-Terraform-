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
