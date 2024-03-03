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
      cidr_blocks = ["sg-09132d5dee9e5e106"] //Dev-Salary-lb-sg ID  
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
*--------------------------------------------------------------------------------------------------*
variable "alb_name" {
  description = "Name for the ALB"
}

variable "internal_alb" {
  description = "Whether the ALB is internal or not"
}

variable "security_groups" {
  description = "List of security group IDs for the ALB"
  type        = list(string)
}

variable "subnets" {
  description = "List of subnet IDs for the ALB"
  type        = list(string)
}

variable "listener_port" {
  description = "Port for the listener"
}

variable "target_group_name" {
  description = "Name for the target group"
}

variable "target_group_port" {
  description = "Port for the target group"
}

variable "vpc_id" {
  description = "ID of the VPC"
}

variable "health_check_path" {
  description = "Path for the health check"
}

variable "health_check_port" {
  description = "Port for the health check"
}

variable "health_check_timeout" {
  description = "Timeout for the health check"
}

variable "health_check_interval" {
  description = "Interval for the health check"
}

variable "health_check_healthy_threshold" {
  description = "Healthy threshold for the health check"
}

variable "health_check_unhealthy_threshold" {
  description = "Unhealthy threshold for the health check"
}

variable "listener_rule_priority" {
  description = "Priority for the listener rule"
}

variable "listener_rule_host_values" {
  description = "Host header values for the listener rule"
  type        = list(string)
}
