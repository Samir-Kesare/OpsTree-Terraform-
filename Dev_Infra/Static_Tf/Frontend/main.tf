#---------------------------------Security Group ----------------------------------#

locals {
  inbound_ports         = var.inbound_ports
  outbound_ports        = var.outbound_ports
}
resource "aws_security_group" "security_group" {
  name                  = var.security_name
  description           = var.Security_description
  vpc_id                = var.SG_vpc_id

  dynamic "ingress" {
  for_each              = local.inbound_ports
  content {
   from_port            = ingress.value.port
   to_port              = ingress.value.port
   protocol             = ingress.value.protocol
   # Conditionally apply CIDR block or security group rule based on type
   cidr_blocks      = contains(keys(ingress.value), "cidr_blocks") ? [ingress.value.cidr_blocks] : null
   security_groups  = contains(keys(ingress.value), "security_group_ids") ? [ingress.value.security_group_ids] : null
  }
 }
 dynamic "egress" {
  for_each              = local.outbound_ports
  content {
   from_port            = egress.value.port
   to_port              = egress.value.port
   protocol             = egress.value.protocol
   cidr_blocks          = [egress.value.cidr_blocks]
  }
 }
  tags                  = var.Sg_tags
}
#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------Launch Template ----------------------------------#

# First Create AMI for Template

resource "aws_ami_from_instance" "AMI" {
  name               = var.AMI_name
  source_instance_id = var.AMI_Instance_ID
}

# Generate Private Key
resource "tls_private_key" "private_key" {
  algorithm = var.private_key_algorithm
  rsa_bits  = var.private_key_rsa_bits
}

# Generate SSH Key Pair
resource "aws_key_pair" "key_pair" {
  key_name   = var.instance_keypair
  public_key = tls_private_key.private_key.public_key_openssh
}

# Download Private Key in PEM Format
resource "local_file" "private_key" {
  content  = tls_private_key.private_key.private_key_pem
  filename = "${var.instance_keypair}.pem"
}

resource "aws_launch_template" "Template" {
  name                      = var.template_name
  description               = var.template_description
  image_id                  = aws_ami_from_instance.AMI.id         # if your AMI alreday created then give your AMI ID
  instance_type             = var.instance_type
  key_name                  = aws_key_pair.key_pair.key_name
  network_interfaces {
    security_groups         = [aws_security_group.security_group.id]
    subnet_id               = var.subnet_ID 
  }
  user_data = base64encode(templatefile("./script.sh", { ALB_DNS = aws_lb.Dev_Alb.dns_name }))
  tags = {  
    Name                  = var.template_name
  }
  depends_on = [ aws_lb.Dev_Alb ]
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------- Target Group -----------------------------------#

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

# Attach instances to the target group

# resource "aws_lb_target_group_attachment" "Target_group_attachment" {
#   for_each         = toset(var.instance_ids)
#   target_group_arn = aws_lb_target_group.Target_group.arn
#   target_id        = each.value
#   port             = var.target_group_port
# }


#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#------------------------------- Listener rule of ALB -----------------------------#

# Configure ALB

resource "aws_lb" "Dev_Alb" {
  name               = var.alb_name
  internal           = var.internal
  load_balancer_type = var.load_balancer_type
  security_groups    = var.security_groups
  subnets            = var.subnets
  tags = {
    Name = var.alb_name
  }
}


# Create listener

resource "aws_lb_listener" "Listener" {
  load_balancer_arn   = aws_lb.Dev_Alb.arn
  port                = var.alb_listener_port
  protocol            = var.alb_listener_portocol

  default_action {
    type              = var.alb_listener_type
    target_group_arn  = aws_lb_target_group.Target_group.arn
  }
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------Configure Auto Scaling group ---------------------------#

resource "aws_autoscaling_group" "Frontend_asg" {
  name                  = var.autoscaling_group_name
  launch_template {
    id                  = aws_launch_template.Template.id
    version             = "$Latest"
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
    propagate_at_launch = var.propagate_at_launch
  }
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
