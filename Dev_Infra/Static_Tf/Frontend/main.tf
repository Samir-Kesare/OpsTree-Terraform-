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
