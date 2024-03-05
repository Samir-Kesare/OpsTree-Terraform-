# Security Group For ScyllaDB Servers #

resource "aws_security_group" "scylladb_sg" {
  name        = "ScyllaDB-sg"
  description = "Security group for Scylla DB Servers"

  vpc_id = var.vpc_id

  dynamic "ingress" {
    for_each = {
      "ssh_management" = var.management_vpc_cidr
      "ssh_openvpn"    = var.openvpn_sg_id
      "scylladb_backend"  = var.backend_sg_id
    }
    content {
      from_port       = ingress.value == var.management_vpc_cidr ? var.ssh_port : ingress.value == var.openvpn_sg_id ? var.ssh_port : var.scylladb_port
      to_port         = ingress.value == var.management_vpc_cidr ? var.ssh_port : ingress.value == var.openvpn_sg_id ? var.ssh_port : var.scylladb_port
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

/*-----------Scylla DB Server-------------------*/

resource "aws_instance" "scylladb_server" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.scylladb_server_type
  key_name                    = aws_key_pair.key_pair.key_name
  subnet_id                   = var.db_subnet_id
  associate_public_ip_address = false
  vpc_security_group_ids      = [aws_security_group.scylladb_sg.id]
  tags = {
    Name = var.scylladb_name
    Type = "scylladb"
  }

}
