/*---------------vpc variables---------------*/

variable "vpc_cidr" {
  type    = string
  default = "10.0.1.0/24"
}

variable "vpc_enable_dns_support" {
  type    = bool
  default = true
}

variable "vpc_enable_dns_hostnames" {
  type    = bool
  default = false
}

variable "vpc_tags" {
  type    = map(string)
  default = {
    Name = "dev-vpc"
    Enviroment = "dev"
    Owner = "harshit"
  }
}