// Output for the created AWS security group
output "security_group_id" {
  value = aws_security_group.salary_sg.id
}
*--------------------------------------------------------------------------------------------------------*
utput "alb_arn" {
  value = aws_lb.dev_alb.dns_name
}

output "dev_salary_tg_arn" {
  value = aws_lb_target_group.dev_salary_tg.arn
}

output "listener_rule_priority" {
  value = aws_lb_listener_rule.dev_listener_rule.priority
}
