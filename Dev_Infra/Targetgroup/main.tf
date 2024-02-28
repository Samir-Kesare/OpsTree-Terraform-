*-------------------------------------------------------------------------------------------*
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
  tags = {
    Name = var.security_group_name
  }
}

*-------------------------------------------------------------------------------------------*
//Launch-Template
resource "aws_launch_template" "salary_launch_template" {
  name_prefix   = var.launch_template_name_prefix
  description   = var.launch_template_description

  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size = var.volume_size
      volume_type = var.volume_type
    }
  }

  instance_type        = var.instance_type
  security_group_names = var.security_group_names

  # You can add more configurations as needed
}

*---------------------------------------------------------------------------------------------------*
//Target-Group
*------------------------------------------------------------------------------------------------------*
resource "aws_lb_target_group" "salary_target_group" {
  name        = var.target_group_name
  port        = var.target_group_port
  protocol    = var.target_group_protocol
  vpc_id      = var.vpc_id

  health_check {
    path                = var.health_check_path
    protocol            = "HTTP"
    port                = var.health_check_port
    interval            = var.health_check_interval
    timeout             = var.health_check_timeout
    healthy_threshold   = var.health_check_healthy_threshold
    unhealthy_threshold = var.health_check_unhealthy_threshold
  }

  tags = {
    Name = var.target_group_name
  }
}
