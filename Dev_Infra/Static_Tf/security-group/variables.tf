
#---------------------------------Security Group ----------------------------------#

variable "security_name" {
  description     = "Name tag for the security group"
  type            = string
  default         = "Frontend-sg"
}
variable "Security_description" {
  description     = "Description for the security group"
  type            = string
  default         = "Security group for Frontend-API"
}
variable "vpc_id" {
  description     = "ID of the VPC for instances"
  type            = string
  default         = "vpc-0383f4dc3af051efa"
}
variable "inbound_ports" {
  description     = "List of inbound ports and protocols and cidr block"
  type            = list(map(any))
  default         = [
    { port = 22, protocol = "tcp",cidr_blocks = "20.0.0.0/28" }, # Management VPC Cidr Block
    { port = 3000, protocol = "tcp", cidr_blocks = "0.0.0.0/0" }, #  Frontend-lb-sg ID Repalce (0.0.0.0/0)
  ]
}

variable "outbound_ports" {
  description     = "List of outbound ports and protocols and Cidr block "
  type            = list(map(any))
  default         = [
    { port = 0, protocol = "-1", cidr_blocks = "0.0.0.0/0", },
  ]
}
variable "Sg_tags" {
  type            = map(string)
  default         = {
    Name          = "Frontend-sg"
    Enviroment    = "dev"
    Owner         = "Vishal"
  }
}
#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
