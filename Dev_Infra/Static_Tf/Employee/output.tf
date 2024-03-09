#---------------------------------Security Group ----------------------------------#

output "Security_Group_ID" {
  value = [aws_security_group.security_group.id]
}

#--------------------------------Launch Template ----------------------------------#

# AMI
output "AMI_ID" {
    value = [aws_ami_from_instance.AMI.id] 
}

# Priavte Key
output "key_pair_name" {
  description = "key name"
  value       = [aws_key_pair.key_pair.key_name]
}

# Template
output "launch_template_id" {
  value = [aws_launch_template.Template.id]
}

#--------------------------------- Target Group -----------------------------------#

output "Target_group_id" {
  value = [aws_lb_target_group.Target_group.id]
}

#------------------------------- Listener rule of ALB -----------------------------#

output "target_group_arn" {
  value = [aws_lb_target_group.Target_group.arn]
}

#--------------------------Configure Auto Scaling group ---------------------------#

output "Autoscaling_group_id" {
  value = [aws_autoscaling_group.Employee_asg.id]
}
