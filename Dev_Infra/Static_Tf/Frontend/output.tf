#---------------------------------Security Group ----------------------------------#

output "Security_Group_ID" {
  value = [aws_security_group.sq_grp.id]
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
