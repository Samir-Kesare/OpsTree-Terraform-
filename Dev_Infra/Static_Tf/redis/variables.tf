variable "vpc_id" {
  description = " VPC id of the Development VPC"
  type        = string
}
variable "backend_sg_id" {
  description = "SG id of the backend servers"
  type        = string
}
variable "openvpn_sg_id" {
  description = "SG id of OpenVPN server"
  type        = string
}
variable "management_vpc_cidr" {
  description = "Management VPC Subnet CIDR"
  type        = string
}
variable "redis_port" {
  description = "Default redis port"
  type        = string
  default     = "6379"
}
variable "ssh_port" {
  description = "Default SSH port"
  type        = string
  default     = "22"
}
variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
}

variable "redis_server_type" {
  description = "Instance type for Redis server"
  type        = string
}

variable "db_subnet_id" {
  description = "ID of the subnet for the Redis server"
  type        = string
}

variable "redis_name" {
  description = "Name tag for the Redis server"
  type        = string
}
