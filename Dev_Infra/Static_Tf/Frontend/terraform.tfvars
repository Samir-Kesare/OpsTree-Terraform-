#---------------------------------Security Group ----------------------------------#

security_name                 = "Dev-Frontend-sg"
Security_description          = "Security group for Dev-Frontend-API"
SG_vpc_id                     = "vpc-0383f4dc3af051efa"

inbound_ports                 = [
    { port = 22, protocol = "tcp",cidr_blocks = "20.0.0.0/28" }, # Management VPC Cidr Block
    { port = 3000, protocol = "tcp", security_group_ids = "sg-0b426399b2b19b0ae" }, #  Dev-Frontend-lb-sg ID
    { port = 22, protocol = "tcp", security_group_ids = "sg-0f470a22a92136557" },    # OpenVPN-SG
  ]

outbound_ports                = [
    { port = 0, protocol = "-1", cidr_blocks = "0.0.0.0/0", },
  ]

Sg_tags                       = {
    Name          = "Dev-Frontend-sg"
    Enviroment    = "dev"
    Owner         = "Vishal"
  }   

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
