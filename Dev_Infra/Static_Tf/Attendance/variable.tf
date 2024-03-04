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

// launch template
variable "template_name" {
  description = "The name of the launch template"
  type        = string
  default     = "AttendanceAPI-Launch-Template"
}

variable "template_description" {
  description = "description of launch template"
  type        = string
  default     = "Launch template for attendance api"
}

variable "instance_type" {
  description = "The type of instance to launch"
  type        = string
  default     = "t2.micro"
}

variable "subnet_ID" {
  description = "The ID of the subnet"
  type        = string
  default     = "subnet-0e01736fe7c278323"
}


// AMI

variable "AMI_name" {
  description     = "Give AMI Name"
  type            = string
  default         = "Dev-Attendance-AMI" 
}
variable "AMI_Instance_ID" {
  description     = "Give Dev-Attendance Instance ID"
  type            = string
  default         = "i-0572a5faad61b261e"  # Instance ID of Attendance-API
}

// Generate Key

variable "private_key_algorithm" {
  description = "value"
  type = string
  default = "RSA"
}
variable "private_key_rsa_bits" {
  description = "value"
  type = number
  default = 4096
}

variable "instance_keypair" {
  description     = "Launch Template Instance Type keypair name"
  type            = string
  default         = "Dev_Key"  
}