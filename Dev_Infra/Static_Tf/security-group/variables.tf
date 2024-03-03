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
      cidr_blocks = ["sg-0367a02ed8f7d5565"]
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["20.0.0.0/28"]
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
