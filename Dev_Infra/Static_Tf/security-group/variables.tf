variable "security_group_name" {
  description = "Name of the security group"
  default     = "salary-sg"
}

variable "security_group_description" {
  description = "Description for the security group"
  default     = "Security group for Salary application"
}

variable "vpc_id" {
  description = "ID of the VPC"
  default     = "vpc-0ebc6865d6c6a5460"
}

variable "http_port" {
  description = "Port for HTTP traffic"
  default     = 8080
}
variable "ssh_port" {
  description = "Port for SSH traffic"
  default     = 22
}

variable "ssh_port" {
  description = "Port for SSH traffic"
  default     = 22
}

variable "ingress_rules" {
  description = "List of ingress rules"
  type        = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      from_port   = 8080 
      to_port     = 8080
      protocol    = "tcp"
      cidr_blocks = ["sg-0367a02ed8f7d5565"] //Dev-Salary-lb-sg ID  
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["20.0.0.0/28"]  //Management VPC Cidr Block
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["sg-0367a02ed8f7d5565"]  //OpenVPN-SG
    }
  ]
}

variable "egress_rules" {
  description = "List of egress rules"
  type        = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}
variable "Sg_tags" {
  type            = map(string)
  default         = {
    Name          = "salary-sg"
    Enviroment    = "dev"
    Owner         = "Shikha"
  }
}

*-------------------------------------------------------------------------------------------------*
// launch template
variable "template_name" {
  description = "The name of the launch template"
  type        = string
  default     = "Salary API-Launch-Template"
}

variable "template_description" {
  description = "description of launch template"
  type        = string
  default     = "Launch template for salary api"
}

variable "instance_type" {
  description = "The type of instance to launch"
  type        = string
  default     = "t2.micro"
}

variable "subnet_ID" {
  description = "The ID of the subnet"
  type        = string
  default     = "subnet-013843b2702f341f4"
}


// AMI

variable "AMI_name" {
  description     = " AMI Name"
  type            = string
  default         = "Dev-Salary-AMI" 
}
variable "AMI_Instance_ID" {
  description     = " Dev-Salary Instance ID"
  type            = string
  default         = "i-069d5031c2f20d32b"  # Instance ID of Salary-API
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
