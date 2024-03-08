// VARIABLES

// AWS region in provider.tf
variable "region" {
  description = "AWS region"
  default     = "us-east-1"
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
  type = list(map(any))
  default = [
    {
      port     = 22
      source   = "20.0.0.0/28"   //cidr for management vpc 
      protocol = "tcp"  
    },
   {
     port     = 22
     security_group_ids = "sg-0add0279237c66ee0" // Replace it with OpenVPN-sg
     protocol = "tcp"  
    },
    {
      port     = 8080
      security_group_ids   = "sg-0add0279237c66ee0" // replace it with attendance-lb-sg
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
  default     = "subnet-0a712151efeb16f4f"
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
  default         = "i-019f7170b97a143c7"  # Instance ID of Attendance-API
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
  default         = "Dev_Key_attendence"  
}

// Target groups 

variable "target_group_name" {
  description = "The name of the target group"
  type        = string
  default         = "Dev-Attendance-TG"
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
  default         = "vpc-0d744158f7f47f419" // dev vpc id
}

variable "health_check_path" {
  description = "The destination for the health check request"
  type        = string
  default         = "/api/v1/attendance/health"
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

// Listener rule

variable "listener_arn" {
  description = "ARN of the existing listener where the rule will be added"
  type        = string
  default = "arn:aws:elasticloadbalancing:us-east-1:905418193488:listener/app/alb-heh/127dfdd55a957475/99ac24ae778e4e38"
}

variable "path_pattern" {
  description = "Path pattern for the listener rule"
  type        = string
  default     = "/api/v1/attendance/*"
}

variable "action_type" {
  description = "Path pattern for the listener rule"
  type        = string
  default     = "forward"
}

// ASG 

variable "asg_name" {
  description     = "The name of the Auto Scaling Group"
  type            = string
  default         = "Dev_Attendance_ASG"
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
  default         = [ "subnet-0ee90c13919484fb8" ]    #Attendance-Pvt-Subnet ID
}

variable "tag_key" {
  description     = "The key for the tag to be applied to the ASG and instances"
  type            = string
  default         = "Name"
}

variable "tag_value" {
  description     = "The value for the tag to be applied to the ASG and instances"
  type            = string
  default         = "Dev_Attendance_ASG"
}

variable "propagate_at_launch" {
  description     = "Whether the tag should be propagated to instances launched by the ASG"
  type            = bool
  default         = false
}

// ASG policy

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
