
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

/*------------Genrate-Key--------------*/
resource "tls_private_key" "rsa_4096" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

/*----------pem Key----------------------*/
resource "aws_key_pair" "key_pair" {
  key_name   = var.key_name
  public_key = tls_private_key.rsa_4096.public_key_openssh
}

/*----------Download Pem Key-------------------*/
resource "local_file" "private_key" {
  content  = tls_private_key.rsa_4096.private_key_pem
  filename = var.key_name
}

/*-----------Redis Server-------------------*/

resource "aws_instance" "redis_server" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.redis_server_type
  key_name                    = aws_key_pair.key_pair.key_name
  subnet_id                   = var.db_subnet_id
  associate_public_ip_address = false
  vpc_security_group_ids      = [aws_security_group.redis_sg.id]
  tags = {
    Name = var.redis_name
    Type = "redis"
  }

}
