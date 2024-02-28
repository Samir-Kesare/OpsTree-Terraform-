*----------------------------------------------------------------------------------------------------*
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
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
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

*----------------------------------------------------------------------------------------------------*
variable "launch_template_name_prefix" {
  description = "Prefix for the name of the launch template"
  default     = "salary-launch-template"
}

variable "launch_template_description" {
  description = "Description for the launch template"
  default     = "Launch Template for Salary application"
}

variable "instance_type" {
  description = "Instance type for the launch template"
  default     = "t2.micro"
}

variable "security_group_names" {
  description = "List of security group names for instances launched using this template"
  type        = list(string)
  default     = ["salary-sg"]
}

variable "volume_size" {
  description = "Size of the EBS volume (in GB)"
  default     = 20
}

variable "volume_type" {
  description = "Type of the EBS volume"
  default     = "gp2"
}
