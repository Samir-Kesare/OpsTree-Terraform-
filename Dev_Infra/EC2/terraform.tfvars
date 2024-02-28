
inbound_ports           = [
    { port = 22, protocol = "tcp",cidr_blocks = "20.0.0.0/28" }, # Management VPC Cidr Block
    { port = 5432, protocol = "tcp", cidr_blocks = "0.0.0.0/0" }, #  Backend-sg
  ]

outbound_ports          = [
    { port = 0, protocol = "-1", cidr_blocks = "0.0.0.0/0", },
  ]

Security_group_tags      = {
    Name          = "Postgres-sg"
    Enviroment    = "dev"
    Owner         = "Vikram"
  }   

#---------------------------------EC2 Instance ----------------------------------#



aws_region     = "ap-northeast-1"
instance_ami   = "ami-07c589821f2b353aa"
instance_type  = "t2.medium"
key_name       = "tokyo"
private_subnet_cidr_block = "10.0.1.0/24"
vpc_cidr_block = "10.0.0.0/16"
availability_zone         = "ap-northeast-1a"
private_subnet_name       = "DB-Pvt_Subnet"
security_name = "Postgres_sg"
vpc_id                  = "vpc-0fd6d3005998fb58c"
vpc_name                  = "Dev-VPC"

Postgres_Instance_tag      = {
    Name          = "Postgres_Instance"
    Enviroment    = "dev"
    Owner         = "Vikram"
  }
