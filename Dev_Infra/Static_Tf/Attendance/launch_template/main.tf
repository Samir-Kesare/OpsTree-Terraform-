resource "aws_security_group" "attendance-sg" {
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

resource "aws_launch_template" "Attendance_Launch_Template" {
  name          = var.template_name
  description   = var.template_description
  image_id      = var.image_id
  instance_type = var.instance_type
  key_name = var.key_name

  network_interfaces {
    security_groups         = var.security_group_ids
    subnet_id               = var.subnet_ID
  }

  user_data = filebase64("./script.sh")
  tags = {  
    Name                  = var.template_name
  }

}
