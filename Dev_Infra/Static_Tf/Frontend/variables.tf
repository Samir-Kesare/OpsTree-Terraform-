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
  description     = "Tags for Security Group"
  type            = map(string)
  default         = {
    Name          = "Frontend-sg"
    Enviroment    = "dev"
    Owner         = "Vishal"
  }
}
#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------Launch Template ----------------------------------#


# AMI
variable "AMI_name" {
  description     = "Give AMI Name"
  type            = string
  default         = "Fronted-AMI" 
}
variable "AMI_Instance_ID" {
  description     = "Give Instance ID"
  type            = string
  default         = "i-01cbd03e43fabd05d"  
}

# Launch Template 

variable "template_name" {
  description     = "Launch Template Name"
  type            = string
  default         = "Frontend-template"  
}
variable "template_description" {
  description     = "Launch Template Description"
  type            = string
  default         = "Template for Frontend"  
}
variable "instance_type" {
  description     = "Launch Template Instance Type"
  type            = string
  default         = "t2.micro"  
}
variable "instance_keypair" {
  description     = "Launch Template Instance Type keypair name"
  type            = string
  default         = "newkey"  
}
variable "subnet_ID" {
  description     = "Launch Template Subnet ID"
  type            = string
  default         = "subnet-04c0c823118f48202"  
  
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#




