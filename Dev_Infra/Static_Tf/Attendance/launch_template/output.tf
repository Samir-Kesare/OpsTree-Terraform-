output "launch_template_arn" {
  description = "The ARN of the created launch template"
  value       = aws_launch_template.Attendance_Launch_Template.arn
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

output "Security_Group_ID" {
  value = [aws_security_group.attendance-sg.id]
}