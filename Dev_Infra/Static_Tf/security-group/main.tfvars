

security_name           = "Salary-sg"
Security_description    = "Security group for Salary-API"
vpc_id                  = "vpc-0ebc6865d6c6a5460"

inbound_ports           = [
    { port = 22, protocol = "tcp",cidr_blocks = "20.0.0.0/28" }, # Management VPC Cidr Block
    { port = 8080, protocol = "tcp", cidr_blocks = "0.0.0.0/0" }, #  Salary-lb-sg ID Repalce (0.0.0.0/0)
  ]

outbound_ports          = [
    { port = 0, protocol = "-1", cidr_blocks = "0.0.0.0/0", },
  ]

Sg_tags                 = {
    Name          = "Salary-sg"
    Enviroment    = "dev"
    Owner         = "Shikha"
  }   


