
#---------------------------------Security Group ----------------------------------#

security_name           = "Frontend-sg"
Security_description    = "Security group for Frontend-API"
vpc_id                  = "vpc-0383f4dc3af051efa"

inbound_ports           = [
    { port = 22, protocol = "tcp",cidr_blocks = "20.0.0.0/28" }, # Management VPC Cidr Block
    { port = 3000, protocol = "tcp", cidr_blocks = "0.0.0.0/0" }, #  Frontend-lb-sg ID Repalce (0.0.0.0/0)
  ]

outbound_ports          = [
    { port = 0, protocol = "-1", cidr_blocks = "0.0.0.0/0", },
  ]

Sg_tags                 = {
    Name          = "Frontend-sg"
    Enviroment    = "dev"
    Owner         = "Vishal"
  }   

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
