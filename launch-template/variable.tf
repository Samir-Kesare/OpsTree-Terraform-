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
