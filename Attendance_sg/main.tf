// RESOURCES

resource "aws_security_group" "attendance-sg" {
  name        = var.security_group_name
  description = var.description
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.inbound_rules
    content {
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = ingress.value.protocol
      cidr_blocks = [ingress.value.source]
    }
  }

  dynamic "egress" {
    for_each = var.outbound_rules
    content {
      from_port       = egress.value.port
      to_port         = egress.value.port
      protocol        = egress.value.protocol
      cidr_blocks     = [egress.value.source]
    }
  }
  tags = var.sg_tags
}


// VARIABLES

variable "security_group_name" {
  description = "security group name"
  type            = string
  default         = "attendance-sg"
}

variable "description" {
  description = "security group for Attendance API"
  type            = string
  default         = "Security group for Attendance-API"
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type = string
  default = "vpc-0d744158f7f47f419"
}

variable "inbound_rules" {
  description = "List of inbound rules for the security group"
  type = list(object({
    port     = number
    source   = string
    protocol = string
  }))
  default = [
    {
      port     = 22
      source   = "20.0.0.0/28"   //cidr for management vpc 
      protocol = "tcp"  
    },
    {
      port     = 8080
      source   = "0.0.0.0/0" // replace it with frontend-lb-sg
      protocol = "tcp"  
    }
  ]
}

variable "outbound_rules" {
  description = "List of outbound rules for the security group"
  type = list(object({
    port     = number
    source   = string
    protocol = string
  }))
  default = [
    {
      port     = 0 // allow all ports 
      source   = "0.0.0.0/0"
      protocol = "-1"  // all protocols
    }
  ]
}

variable "sg_tags" {
  description = "Tag for Attedance sg"
  type        = map(string)
  default     = {
    Name = "Attendance-sg"
    Environment = "Dev"
    Owner         = "Vidhi"
  }
}

//OUTPUT
output "security_group_id" {
  value = aws_security_group.attendance-sg.id
}

//PROVIDER

// required terraform configuration
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.38.0"  # Using a minimum version constraint
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  alias = "east"
  region = "us-east-1"  
}