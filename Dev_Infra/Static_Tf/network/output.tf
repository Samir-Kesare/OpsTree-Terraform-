output "vpc-id" {
  value = aws_vpc.dev-vpc.id
}

output "public-subnets-id" {
  value = aws_subnet.public_subnets.*.id
}


output "private-subnets-id" {
  value = aws_subnet.private_subnets.*.id
}
