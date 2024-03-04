// VARIABLES

// AWS region in provider.tf
variable "region" {
  description = "AWS region"
  default     = "ap-northeast-1"
}

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
