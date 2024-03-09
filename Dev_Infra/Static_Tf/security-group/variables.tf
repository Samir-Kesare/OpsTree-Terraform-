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
*-------------------------------------------------------------------------------------------------------------*
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

*-------------------------------------------------------------------------------------------------------*
// Target groups 

variable "target_group_name" {
  description = "The name of the target group"
  type        = string
  default         = "Dev-Salary-TG"
}

variable "target_group_port" {
  description = "The port on which targets receive traffic"
  type        = number
  default         = 8080
  default         = 80
}

variable "target_group_protocol" {
  description = "The protocol to use for routing traffic to the targets"
  type        = string
  default         = "HTTP"
}

variable "TG_vpc_id" {
  description = "The VPC ID"
  type        = string
  default         = "vpc-0ebc6865d6c6a5460" // dev vpc id
}

variable "health_check_path" {
  description = "The destination for the health check request"
  type        = string
  default         = "/api/v1/salary/health"
}

variable "health_check_port" {
  description = "The port to use to connect with the target"
  type        = string
  default         = "traffic-port"
}

variable "health_check_interval" {
  description = "The approximate amount of time, in seconds, between health checks of an individual target"
  type        = number
  default         = 30
}

variable "health_check_timeout" {
  description = "The amount of time, in seconds, during which no response from a target means a failed health check"
  type        = number
  default         = 5
}

variable "health_check_healthy_threshold" {
  description = "The number of consecutive health checks successes required before considering an unhealthy target healthy"
  type        = number
  default     = 5
}
variable "health_check_unhealthy_threshold" {
  description = "The number of consecutive health check failures required before considering a target unhealthy"
  type        = number
  default     = 2
}
# Configure ALB

variable "alb_name" {
  description     = "Name for the Application Load Balancer"
  type            = string
  default         = "Dev-ALB"
}
variable "internal" {
  description     = "Boolean flag indicating whether the ALB is internal or external"
  type            = bool
  default         = false
}
variable "load_balancer_type" {
  description     = "Type of the load balancer"
  type            = string
  default         = "application"
}
variable "security_groups" {
  description     = "List of security group IDs for the ALB"
  type            = list(string)
  default         = ["sg-09132d5dee9e5e106"]  # Salary-lb-sg ID
}
variable "subnets" {
  description     = "List of subnet IDs for the ALB"
  type            = list(string)
  default         = ["subnet-0a2270e6f508e903d", "subnet-06a5a25b82ec957cf"]  # Public subnet IDs 
}


// Listener rule

variable "listener_arn" {
  description = "ARN of the existing listener where the rule will be added"
  type        = string
  default = "arn:aws:elasticloadbalancing:us-east-1:975050171850:listener/app/ALB/49e9e7b843170b35/85a562da2e108bf6"
}

variable "path_pattern" {
  description = "Path pattern for the listener rule"
  type        = string
  default     = "/api/v1/salary/*"
}

variable "action_type" {
  description = "Path pattern for the listener rule"
  type        = string
  default     = "forward"
}

variable "target_group_arn" {
  description = "ARN of the target group"
  type        = string
  default     = "arn:aws:elasticloadbalancing:us-east-1:975050171850:targetgroup/salaryapi/8f778507e433b5f1"
}
