#---------------------------------Security Group ----------------------------------#

security_name                 = "Dev-Frontend-sg"
Security_description          = "Security group for Dev-Frontend-API"
SG_vpc_id                     = "vpc-0383f4dc3af051efa"

inbound_ports                 = [
    { port = 22, protocol = "tcp",cidr_blocks = "20.0.0.0/28" }, # Management VPC Cidr Block
    { port = 3000, protocol = "tcp", security_group_ids = "sg-0b426399b2b19b0ae" }, #  Dev-Frontend-lb-sg ID
    { port = 22, protocol = "tcp", security_group_ids = "sg-0f470a22a92136557" },    # OpenVPN-SG
  ]

outbound_ports                = [
    { port = 0, protocol = "-1", cidr_blocks = "0.0.0.0/0", },
  ]

Sg_tags                       = {
    Name          = "Dev-Frontend-sg"
    Enviroment    = "dev"
    Owner         = "Vishal"
  }   

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------Launch Template ----------------------------------#

#AMI

AMI_name                = "Dev-Fronted-AMI" 
AMI_Instance_ID         = "i-0572a5faad61b261e"    # Dev-Frontend Instance ID

# Priavte Key

private_key_algorithm   = "RSA"
private_key_rsa_bits    = 4096

# Launch Template

template_name           = "Dev-Frontend-template"
template_description    = "Template for Dev-Frontend"  
instance_type           = "t2.micro" 
instance_keypair        = "Dev_Key" 
subnet_ID               = "subnet-04c0c823118f48202"

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------- Target Group -----------------------------------#

target_group_name                 = "Dev-Frontend-TG"
target_group_port                 = 3000
target_group_protocol             = "HTTP"
TG_vpc_id                         = "vpc-0383f4dc3af051efa"   #  Dev-VPC ID 
health_check_path                 = "/health"
health_check_port                 = "traffic-port"
health_check_interval             = 30
health_check_timeout              = 5
health_check_healthy_threshold    = 2
health_check_unhealthy_threshold  = 2


# Attach instances to the target group

# instance_ids                      = [ "i-0572a5faad61b261e" ]

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
