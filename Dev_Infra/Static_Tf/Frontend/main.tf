#---------------------------------Security Group ----------------------------------#

locals {
  inbound_ports         = var.inbound_ports
  outbound_ports        = var.outbound_ports
}
resource "aws_security_group" "sq_grp" {
  name                  = var.security_name
  description           = var.Security_description
  vpc_id                = var.vpc_id

  dynamic "ingress" {
  for_each              = local.inbound_ports
  content {
   from_port            = ingress.value.port
   to_port              = ingress.value.port
   protocol             = ingress.value.protocol
   cidr_blocks          = [ingress.value.cidr_blocks]
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

# Cretae Launch Template

# Launch Template Resource
resource "aws_launch_template" "Template" {
  name              = var.template_name
  description       = var.template_description
  image_id          = aws_ami_from_instance.AMI.id
  instance_type     = var.instance_type

  vpc_security_group_ids = [aws_security_group.sq_grp.id]
  key_name               = var.instance_keypair
  network_interfaces {
    subnet_id            = var.subnet_ID 
  }
  /*user_data = 
                    #!/bin/bash
                    cd /home/ubuntu/Frontend            # Uncomment When use Actual Instance
                    npm start
  */
  tags = {
    Name                  = var.template_name
  }
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#

