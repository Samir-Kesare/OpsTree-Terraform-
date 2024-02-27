#---------------------------------Security Group ----------------------------------#

output "Security_Group_ID" {
  value = [aws_security_group.sq_grp.id]
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------Launch Template ----------------------------------#

# AMI

output "AMI_ID" {
    value = [aws_ami_from_instance.AMI.id] 
}

# Template
output "launch_template_id" {
  value = aws_launch_template.Template.id
}
#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
