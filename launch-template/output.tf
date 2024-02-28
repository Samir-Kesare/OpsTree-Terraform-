*------------------------------------------------------------------------------------------*
// Output for the created AWS security group
output "security_group_id" {
  value = aws_security_group.salary_sg.id
}
*------------------------------------------------------------------------------------------*

output "launch_template_id" {
  value = aws_launch_template.salary_launch_template.id
}
