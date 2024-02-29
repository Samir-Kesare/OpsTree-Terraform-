*----------------------------------------------------------------------------------------------------*
//Security-Group
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
variable "Sg_tags" {
  type            = map(string)
  default         = {
    Name          = "salary-sg"
    Enviroment    = "dev"
    Owner         = "Shikha"
  }
}

*----------------------------------------------------------------------------------------------------*
//Launch-Template
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
*---------------------------------------------------------------------------------------------------------*
//Target-Group

variable "target_group_name" {
  description = "Name of the target group"
  default     = "salary-target-group"
}

variable "target_group_port" {
  description = "Port for the target group"
  default     = 80
}

variable "target_group_protocol" {
  description = "Protocol for the target group"
  default     = "HTTP"
}

variable "vpc_id" {
  description = "ID of the VPC"
  default     = "vpc-0ebc6865d6c6a5460"
}

variable "health_check_path" {
  description = "The destination for the health check request"
  default     = "/health"
}

variable "health_check_port" {
  description = "The port to use to connect with the target for health checking"
  default     = "traffic-port"
}

variable "health_check_interval" {
  description = "The approximate amount of time, in seconds, between health checks of an individual target"
  default     = 30
}

variable "health_check_timeout" {
  description = "The amount of time, in seconds, during which no response means a failed health check"
  default     = 5
}

variable "health_check_healthy_threshold" {
  description = "The number of consecutive health checks successes required before considering an unhealthy target healthy"
  default     = 2
}

variable "health_check_unhealthy_threshold" {
  description = "The number of consecutive health check failures required before considering a target unhealthy"
  default     = 2
}
