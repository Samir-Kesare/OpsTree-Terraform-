

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
