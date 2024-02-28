// Output for the created AWS security group
output "security_group_id" {
  value = aws_security_group.salary_sg.id
}
