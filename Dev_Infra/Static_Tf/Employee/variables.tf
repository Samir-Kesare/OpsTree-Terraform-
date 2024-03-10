#---------------------------------Security Group ----------------------------------#

variable "security_name" {
  description     = "Name tag for the security group"
  type            = string
  default         = "Dev-Employee-sg"
}
variable "Security_description" {
  description     = "Description for the security group"
  type            = string
  default         = "Security group for Dev-Employee-API"
}
variable "SG_vpc_id" {
  description     = "ID of the VPC for instances"
  type            = string
  default         = "vpc-037273df63a16de65"   # Dev-VPC ID
}
variable "inbound_ports" {
  description     = "List of inbound ports and protocols and cidr block"
  type            = list(map(any))
  default         = [
    { port = 22, protocol = "tcp",cidr_blocks = "20.0.0.0/28" }, # Management VPC Cidr Block
    { port = 22, protocol = "tcp", security_group_ids = "sg-04b7eb5f6320a1aa6" },    # OpenVPN-SG
    { port = 8080, protocol = "tcp", security_group_ids = "sg-04b7eb5f6320a1aa6" }, #  Dev-Frontend-lb-sg ID  
  ]
}
variable "outbound_ports" {
  description     = "List of outbound ports and protocols and Cidr block "
  type            = list(map(any))
  default         = [
    { port = 0, protocol = "-1", cidr_blocks = "0.0.0.0/0", },
  ]
}
variable "Sg_tags" {
  description     = "Tags for Security Group"
  type            = map(string)
  default         = {
    Name          = "Dev-Employee-sg"
    Enviroment    = "dev"
    Owner         = "Shantanu"
  }
}


#--------------------------------Launch Template ----------------------------------#


# AMI

variable "AMI_name" {
  description     = "Give AMI Name"
  type            = string
  default         = "Dev-Employee-AMI" 
}
variable "AMI_Instance_ID" {
  description     = "Give Dev-Employee Instance ID"
  type            = string
  default         = "i-0e1e08aa641b7ed67"  # Dev-employee Instance ID
}

# Key Generate

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

# Launch Template 

variable "template_name" {
  description     = "Launch Template Name"
  type            = string
  default         = "Dev-Employee-template"  
}
variable "template_description" {
  description     = "Launch Template Description"
  type            = string
  default         = "Template for Dev-Employee"  
}
variable "instance_type" {
  description     = "Launch Template Instance Type"
  type            = string
  default         = "t2.medium"  
}
variable "instance_keypair" {
  description     = "Launch Template Instance Type keypair name"
  type            = string
  default         = "Dev_Key"  
}
variable "subnet_ID" {
  description     = "Launch Template Subnet ID"
  type            = string
  default         = "subnet-029ac81220960564f"  
  
}

#--------------------------------- Target Group -----------------------------------#

variable "target_group_name" {
  description     = "Name of the target group"
  type            = string
  default         = "Dev-Employee-TG"
}
variable "target_group_port" {
  description     = "Port for the target group"
  type            = number 
  default         = 8080
}
variable "target_group_protocol" {
  description     = "Protocol for the target group"
  type            = string
  default         = "HTTP"
}
variable "TG_vpc_id" {
  description     = "ID of the VPC"
  type            = string
  default         = "vpc-037273df63a16de65"    #  Emp-VPC ID 
}
variable "health_check_path" {
  description     = "The destination for the health check request"
  type            = string
  default         = "/health"
}
variable "health_check_port" {
  description     = "The port to use to connect with the target for health checking"
  type            = string
  default         = "traffic-port"
}
variable "health_check_interval" {
  description     = "The approximate amount of time, in seconds, between health checks of an individual target"
  type            = number
  default         = 30
}
variable "health_check_timeout" {
  description     = "The amount of time, in seconds, during which no response means a failed health check"
  type            = number
  default         = 5
}
variable "health_check_healthy_threshold" {
  description     = "The number of consecutive health checks successes required before considering an unhealthy target healthy"
  type            = number
  default         = 2
}
variable "health_check_unhealthy_threshold" {
  description     = "The number of consecutive health check failures required before considering a target unhealthy"
  type            = number
  default         = 2
}


#------------------------------- Listener rule of ALB -----------------------------#

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
  default         = ["sg-04b7eb5f6320a1aa6"]  # Employee-lb-sg ID
}
variable "subnets" {
  description     = "List of subnet IDs for the ALB"
  type            = list(string)
  default         = ["subnet-0abcfc7a31b6687b4", "subnet-00ee15fe21368650e"]  # Public subnet IDs 
}


// Listener rule

variable "listener_arn" {
  description = "ARN of the existing listener where the rule will be added"
  type        = string
  default = "arn:aws:elasticloadbalancing:ap-southeast-1:441247711986:listener/app/Dev-ALB/8f76dff48c859255/20e10c3edb27bcd1"
}

variable "path_pattern" {
  description = "Path pattern for the listener rule"
  type        = string
  default     = "/api/v1/employee/*"
}

variable "action_type" {
  description = "Path pattern for the listener rule"
  type        = string
  default     = "forward"
}

variable "target_group_arn" {
  description = "ARN of the target group"
  type        = string
  default     = "arn:aws:elasticloadbalancing:ap-southeast-1:441247711986:targetgroup/Dev-TG/4923d113ed6653f1"
}

#--------------------------Configure Auto Scaling group ---------------------------#

variable "autoscaling_group_name" {
  description     = "The name of the Auto Scaling Group"
  type            = string
  default         = "Dev_Employee_ASG"
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
  default         = [ "subnet-029ac81220960564f" ]    #Employee-Pvt-Subnet ID
}

variable "tag_key" {
  description     = "The key for the tag to be applied to the ASG and instances"
  type            = string
  default         = "Name"
}

variable "tag_value" {
  description     = "The value for the tag to be applied to the ASG and instances"
  type            = string
  default         = "Dev_Employee_ASG"
}

variable "propagate_at_launch" {
  description     = "Whether the tag should be propagated to instances launched by the ASG"
  type            = bool
  default         = true
}

#---------------------------- Auto Scaling Policies -------------------------------#

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
