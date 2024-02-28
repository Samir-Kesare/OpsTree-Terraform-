*------------------------------------------------------------------------------------------*
// Output for the created AWS security group
output "security_group_id" {
  value = aws_security_group.salary_sg.id
}
*------------------------------------------------------------------------------------------*
//Launch-Template
output "launch_template_id" {
  value = aws_launch_template.salary_launch_template.id
}
*-------------------------------------------------------------------------------------------------*
//Target-Group
output "target_group_id" {
  value = aws_lb_target_group.salary_target_group.id
}
