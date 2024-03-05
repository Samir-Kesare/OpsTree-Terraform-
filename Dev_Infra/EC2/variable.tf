
#---------------------------------Security Group ----------------------------------#

variable "security_name" {
  description     = "Name tag for the security group"
  type            = string
  default         = "Postgres_sg"
}
variable "Security_description" {
  description     = "Description for the security group"
  type            = string
  default         = "Security group for Postgres"
}

variable "inbound_ports" {
  description     = "List of inbound ports and protocols and cidr block"
  type            = list(map(any))
  
}

variable "outbound_ports" {
  description     = "List of outbound ports and protocols and Cidr block "
  type            = list(map(any))
 
}
variable "Security_group_tags" {
  type            = map(string)
  default         = {
    Name          = "Postgres-SG"
    Enviroment    = "dev"
    Owner         = "Vikram"
  }
}




#---------------------------------EC2 Instance ----------------------------------#




variable "aws_region" {
  description = "The AWS region to deploy resources"
}

variable "instance_ami" {
  description = "The AMI for the EC2 instance"
}

variable "instance_type" {
  description = "The type of EC2 instance"
}

variable "key_name" {
  description = "The SSH key pair name to use for the instance"
}

variable "vpc_name" {
  description = "Name for the VPC"
  type        = string
}


variable "vpc_id" {
  description     = "ID of the VPC for instances"
  type            = string
}

variable "private_subnet_cidr_block" {
  description = "CIDR block for the private subnet"
  type        = string
}

variable "availability_zone" {
  description = "Availability zone for the private subnet"
  type        = string
}

variable "private_subnet_name" {
  description = "Name for the private subnet"
  type        = string
}


variable "Postgres_Instance_tag" {
  type            = map(string)
  
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

