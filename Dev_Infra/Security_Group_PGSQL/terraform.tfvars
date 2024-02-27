
security_name           = "Postgres-sg"
Security_description    = "Security group for Postgres-sg"
vpc_id                  = "vpc-0fd6d3005998fb58c"

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
