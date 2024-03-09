
#---------------------------------Security Group ----------------------------------#

locals {
  inbound_ports         = var.inbound_ports
  outbound_ports        = var.outbound_ports
}
resource "aws_security_group" "Security_group" {
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
  tags                  = var.Security_group_tags
}



#---------------------------------EC2 Instance ----------------------------------#

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet_cidr_block
  availability_zone = var.availability_zone

  tags = {
    Name = var.private_subnet_name
  }
}

resource "aws_instance" "Postgres_Instance" {
  ami             = var.instance_ami
  instance_type   = var.instance_type
  key_name        = var.key_name
  security_groups = [var.security_name]
  

  subnet_id = aws_subnet.private_subnet.id  

  root_block_device {
    volume_size = 16
  }

  tags = var.Postgres_Instance_tag

  # Disable public IP address assignment
  associate_public_ip_address = false
}
