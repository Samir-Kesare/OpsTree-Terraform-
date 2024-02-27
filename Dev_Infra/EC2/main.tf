#---------------------------------EC2 Instance ----------------------------------#


resource "aws_instance" "Postgres_Instance" {
  ami           = var.instance_ami
  instance_type = var.instance_type
  key_name      = var.key_name
  security_groups = [var.security_name]


root_block_device {
    volume_size = 16
  }
  
 tags                  = var.Postgres_Instance_tag
  
  }
