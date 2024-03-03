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

variable "image_id" {
  description = "ID of the AMI"
  type        = string
  default     = "ami-0a931e3a8c9589ff9"
}

variable "instance_type" {
  description = "The type of instance to launch"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "The name of the key pair"
  type        = string
}

variable "security_group_ids" {
  description = "The IDs of the security groups"
  type        = list(string)             // can be multiple security groups, not just one
  default     = ["sg-0f41d86318091e8ef"]
}

variable "subnet_ID" {
  description = "The ID of the subnet"
  type        = string
  default     = "subnet-0e01736fe7c278323"
}

variable "region" {
  description = "AWS region"
  default     = "ap-northeast-1"
}
