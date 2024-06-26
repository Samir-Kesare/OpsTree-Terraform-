//OUTPUT
output "security_group_id" {
  value = aws_security_group.attendance_sg.id
}

output "launch_template_id" {
  description = "The ID of the created launch template"
  value       = aws_launch_template.Attendance_Launch_Template.id
}

output "key_pair_name" {
  description = "key name"
  value       = [aws_key_pair.key_pair.key_name]
}

output "AMI_ID" {
    value = [aws_ami_from_instance.AMI.id] 
}

output "Target_group_id" {
  value = [aws_lb_target_group.Target_group.id]
}

// ALB

output "target_group_arn" {
  value = [aws_lb_target_group.Target_group.arn]
}



