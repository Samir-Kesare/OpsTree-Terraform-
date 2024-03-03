  
# Security Group For Redis Servers #

resource "aws_security_group" "redis_sg" {
  name        = "Redis-sg"
  description = "Security group for Redis Servers"

  vpc_id = var.vpc_id

  dynamic "ingress" {
    for_each = {
      "ssh_management" = var.management_vpc_cidr
      "ssh_openvpn"    = var.openvpn_sg_id
      "redis_backend"  = var.backend_sg_id
    }
    content {
      from_port       = ingress.value == var.management_vpc_cidr ? 22 : ingress.value == var.openvpn_sg_id ? 22 : 6379
      to_port         = ingress.value == var.management_vpc_cidr ? 22 : ingress.value == var.openvpn_sg_id ? 22 : 6379
      protocol        = ingress.value == var.management_vpc_cidr ? "tcp" : ingress.value == var.openvpn_sg_id ? "tcp" : "tcp"
      cidr_blocks     = ingress.value == var.management_vpc_cidr ? [ingress.value] : null
      security_groups = ingress.value == var.openvpn_sg_id ? [ingress.value] : ingress.value == var.backend_sg_id ? [ingress.value] : null
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
