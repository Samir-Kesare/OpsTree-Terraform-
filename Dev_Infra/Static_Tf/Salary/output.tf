// Output for the created AWS security group
output "security_group_id" {
  value = aws_security_group.salary-sg.id
}

// Launch Template
output "launch_template_id" {
  description = "The ID of the created launch template"
  value       = aws_launch_template.Salary_Launch_Template.id
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

output "ALB_arn" {
  value = [aws_lb.Dev_Alb.arn] 
}
output "load_balancer_dns_name" {
  value = [aws_lb.Dev_Alb.dns_name]
}

// ASG
output "Autoscaling_group_id" {
  value = [aws_autoscaling_group.Salary_asg.id]
}


// ASG POLICY

output "Autoscaling_policy_name" {
  value  = [aws_autoscaling_policy.Salary_ASG_Policy.name]
}
