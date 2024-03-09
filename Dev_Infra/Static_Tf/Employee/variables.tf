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
  default         = "i-00009a1a28b092841"  # Dev-employee Instance ID
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

# Attach instances to the target group

# variable "instance_ids" {
#   description     = "List of instance IDs to attach to the target group"
#   type            = list(string)
#   default         = [ "i-00009a1a28b092841" ]   # Dev Frontend Instance
# }
