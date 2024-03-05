// RESOURCES

resource "aws_security_group" "attendance_sg" {
  name        = var.security_group_name
  description = var.description
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.inbound_rules
    content {
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = ingress.value.protocol
      cidr_blocks = [ingress.value.source]
    }
  }

  dynamic "egress" {
    for_each = var.outbound_rules
    content {
      from_port       = egress.value.port
      to_port         = egress.value.port
      protocol        = egress.value.protocol
      cidr_blocks     = [egress.value.source]
    }
  }
  tags = var.sg_tags
}

// AMI 
resource "aws_ami_from_instance" "AMI" {
  name               = var.AMI_name
  source_instance_id = var.AMI_Instance_ID
}


// Private Key
resource "tls_private_key" "private_key" {
  algorithm = var.private_key_algorithm
  rsa_bits  = var.private_key_rsa_bits
}

// SSH Key Pair
resource "aws_key_pair" "key_pair" {
  key_name   = var.instance_keypair
  public_key = tls_private_key.private_key.public_key_openssh
}

// Download Private Key in PEM Format
resource "local_file" "private_key" {
  content  = tls_private_key.private_key.private_key_pem
  filename = "${var.instance_keypair}.pem"
}

// Launch template
resource "aws_launch_template" "Attendance_Launch_Template" {
  name          = var.template_name
  description   = var.template_description
  image_id      = aws_ami_from_instance.AMI.id
  instance_type = var.instance_type
  key_name      = aws_key_pair.key_pair.key_name

  network_interfaces {
    security_groups         = [aws_security_group.attendance_sg.id]
    subnet_id               = var.subnet_ID
  }

  user_data = filebase64("./script.sh")
  tags = {  
    Name                  = var.template_name
  }

}

// Target groups 

resource "aws_lb_target_group" "Target_group" {
  name        = var.target_group_name
  port        = var.target_group_port
  protocol    = var.target_group_protocol
  vpc_id      = var.TG_vpc_id

  health_check {
    path                = var.health_check_path
    protocol            = var.target_group_protocol
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

// Listener

// Create listener rule for attendance

resource "aws_lb_listener_rule" "path_rule" {
  listener_arn = var.listener_arn
  priority     = 100
  
  action {
    type             = var.action_type
    target_group_arn = var.target_group_arn
  }
  
  condition {
    path_pattern {
      values = [var.path_pattern]
    }
  }
}

// Create Auto Scaling group 

resource "aws_autoscaling_group" "Attendance_asg" {
  name                  = var.asg_name
  launch_template {
    id                  = aws_launch_template.Attendance_Launch_Template.id
  }
  min_size              = var.min_size
  max_size              = var.max_size
  desired_capacity      = var.desired_capacity
  vpc_zone_identifier   = var.subnet_ids
  target_group_arns     = [
    aws_lb_target_group.Target_group.arn
  ]
  tag {
    key                 = var.tag_key
    value               = var.tag_value
    propagate_at_launch = var.propagate_at_launch  // doesn't specify tag to related resources(instances)
  }
}

