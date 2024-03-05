#---------------------------------Security Group ----------------------------------#

output "Security_Group_ID" {
  value = [aws_security_group.security_group.id]
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
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
#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------- Target Group -----------------------------------#

output "Target_group_id" {
  value = [aws_lb_target_group.Target_group.id]
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#------------------------------- Listener rule of ALB -----------------------------#

# Configure ALB
output "ALB_arn" {
  value = [aws_lb.Dev_Alb.arn] 
}
output "load_balancer_dns_name" {
  value = [aws_lb.Dev_Alb.dns_name]
}

# Listener
output "Listener_arn" {
  value = [aws_lb_listener.Listener.arn]
}



#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------Configure Auto Scaling group ---------------------------#

output "Autoscaling_group_id" {
  value = [aws_autoscaling_group.Frontend_asg.id]
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
