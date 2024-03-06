
#---------------------------------Security Group ----------------------------------#

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
variable "Postgres_port" {
  description = "Default scylladb port"
  type        = string
  default     = "5432"
}
variable "ssh_port" {
  description = "Default SSH port"
  type        = string
  default     = "22"
}
