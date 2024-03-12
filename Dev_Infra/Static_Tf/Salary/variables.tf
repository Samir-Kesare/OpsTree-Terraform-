variable "security_group_name" {
  description = "security group name"
  type            = string
  default         = "salary-sg"
}

variable "description" {
  description = "security group for Salary API"
  type            = string
  default         = "Security group for Salary-API"
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type = string
  default = "vpc-00631f1bf6539cb88"
}

variable "inbound_rules" {
  description = "List of inbound rules for the security group"
  type = list(map(any))
  default = [
    {
      port     = 22
      source   = "20.0.0.0/28"   //cidr for management vpc 
      protocol = "tcp"  
    },
   {
     port     = 22
     security_group_ids = "sg-045b0ff5f6cfe87fc" // Replace it with OpenVPN-sg
     protocol = "tcp"  
    },
    {
      port     = 8080
      security_group_ids   = "sg-0f74269626056367c" // replace it with salary-lb-sg
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
  description = "Tag for Salary sg"
  type        = map(string)
  default     = {
    Name = "Salary-sg"
    Environment = "Dev"
    Owner         = "Shikha"
  }
}


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
  default     = "subnet-03e34296260c1c84d"
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
  default         = "i-05f8654bfaa45cd56"  # Instance ID of Salary-API
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
}

variable "target_group_protocol" {
  description = "The protocol to use for routing traffic to the targets"
  type        = string
  default         = "HTTP"
}

variable "TG_vpc_id" {
  description = "The VPC ID"
  type        = string
  default         = "vpc-00631f1bf6539cb88" // dev vpc id
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
  default         = ["sg-019094ebc2fc3ac97"]  # Salary-lb-sg ID
}
variable "subnets" {
  description     = "List of subnet IDs for the ALB"
  type            = list(string)
  default         = ["subnet-03aa497d8af34753b", "subnet-03e34296260c1c84d"]  # Public subnet IDs 
}


// Listener rule

variable "listener_arn" {
  description = "ARN of the existing listener where the rule will be added"
  type        = string
  default = "arn:aws:elasticloadbalancing:us-east-2:533267160240:listener/app/ALB/be4a2629e59585f7/63e7603c1a41fc34"
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
  default     = "arn:aws:elasticloadbalancing:us-east-2:533267160240:targetgroup/salary-ALB/4c049261c77ea55f"
}

// ASG 

variable "asg_name" {
  description     = "The name of the Auto Scaling Group"
  type            = string
  default         = "Dev_Salary_ASG"
}

variable "min_size" {
  description     = "The minimum number of instances in the ASG"
  type            = number
  default         = 1
}

variable "max_size" {
  description     = "The maximum number of instances in the ASG"
  type            = number
  default         = 2
}

variable "desired_capacity" {
  description     = "The desired number of instances in the ASG"
  type            = number
  default         = 1
}

variable "subnet_ids" {
  description     = "The list of subnet IDs where the instances will be launched"
  type            = list(string)
  default         = [ "subnet-03e34296260c1c84d" ]    #Salary-Pvt-Subnet ID
}

variable "tag_key" {
  description     = "The key for the tag to be applied to the ASG and instances"
  type            = string
  default         = "Name"
}

variable "tag_value" {
  description     = "The value for the tag to be applied to the ASG and instances"
  type            = string
  default         = "Dev_Salary_ASG"
}

variable "propagate_at_launch" {
  description     = "Whether the tag should be propagated to instances launched by the ASG"
  type            = bool
  default         = false
}

// ASG Policy

variable "scaling_policy_name" {
  description     = "The name of the scaling policy"
  type            = string
  default         = "target-tracking-policy"
}
variable "policy_type" {
  description     = "The type of adjustment to make"
  type            = string
  default         = "TargetTrackingScaling"
}
variable "predefined_metric_type" {
  description     = "The predefined metric type for tracking"
  type            = string
  default         = "ASGAverageCPUUtilization"
}
variable "target_value" {
  description     = "The target value for the predefined metric"
  type            = number
  default         = 50.0
}
