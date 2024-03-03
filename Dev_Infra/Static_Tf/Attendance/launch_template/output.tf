output "launch_template_arn" {
  description = "The ARN of the created launch template"
  value       = aws_launch_template.Attendance_Launch_Template.arn
}

output "launch_template_id" {
  description = "The ID of the created launch template"
  value       = aws_launch_template.Attendance_Launch_Template.id
}
