variable "region" {
  description = "The AWS region to deploy resources in"
  default     = "us-east-1"
}

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
