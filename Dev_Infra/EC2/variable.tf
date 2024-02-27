#---------------------------------EC2 Instance ----------------------------------#




variable "aws_region" {
  description = "The AWS region to deploy resources"
}

variable "instance_ami" {
  description = "The AMI for the EC2 instance"
}

variable "instance_type" {
  description = "The type of EC2 instance"
}

variable "key_name" {
  description = "The SSH key pair name to use for the instance"
}

variable "Postgres_Instance_tag" {
  type            = map(string)
  default         = {
    Name          = "Postgres_Instance"
    Enviroment    = "dev"
    Owner         = "Vikram"
  }
}
