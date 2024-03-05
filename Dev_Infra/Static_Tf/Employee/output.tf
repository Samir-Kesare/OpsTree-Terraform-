#---------------------------------Security Group ----------------------------------#

output "Security_Group_ID" {
  value = [aws_security_group.security_group.id]
}
