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
