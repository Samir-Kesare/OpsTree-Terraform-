// Create AWS security group
resource "aws_security_group" "salary_sg" {
  name        = var.security_group_name
  description = var.security_group_description
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = var.egress_rules
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }

  // Tags for the security group
   tags                  = var.Sg_tags
}
*---------------------------------------------------------------------------------------------------------*
resource "aws_lb" "dev_alb" {
  name               = var.alb_name
  internal           = var.internal_alb
  load_balancer_type = "application"
  security_groups    = var.security_groups
  subnets            = var.subnets
}

resource "aws_lb_listener" "dev_listener" {
  load_balancer_arn = aws_lb.dev_alb.arn
  port              = var.listener_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.dev_salary_tg.arn
  }
}

resource "aws_lb_target_group" "dev_salary_tg" {
  name     = var.target_group_name
  port     = var.target_group_port
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = var.health_check_path
    port                = var.health_check_port
    protocol            = "HTTP"
    timeout             = var.health_check_timeout
    interval            = var.health_check_interval
    healthy_threshold   = var.health_check_healthy_threshold
    unhealthy_threshold = var.health_check_unhealthy_threshold
  }
}

resource "aws_lb_listener_rule" "dev_listener_rule" {
  listener_arn = aws_lb_listener.dev_listener.arn
  priority     = var.listener_rule_priority

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.dev_salary_tg.arn
  }

  condition {
    host_header {
      values = var.listener_rule_host_values
    }
  }
}

