security_group_name = "dev-security-group"
security_group_description = "dev security group description"
vpc_id = "vpc-0ebc6865d6c6a5460"
http_port = 8080
ssh_port = 22
ssh_port = 22

ingress_rules = [
  {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["sg-0367a02ed8f7d5565"] //Dev-Salary-lb-sg ID
  },
  {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["20.0.0.0/28"]  //Management VPC Cidr Block

  },
  {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["sg-0367a02ed8f7d5565"] //OpenVPN-SG
  }
]

egress_rules = [
  {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
]
Sg_tags                 = {
    Name          = "salary-sg"
    Enviroment    = "dev"
    Owner         = "Shikha"

  }  

*--------------------------------------------------------------------------------------------------*

template_name = "Salary-Launch-Template"
template_description = "Launch template for salary api"
instance_type = "t2.micro"
subnet_ID = "subnet-013843b2702f341f4"

AMI_name = "Dev-Salary-AMI"
AMI_Instance_ID = "i-069d5031c2f20d32b"

private_key_algorithm = "RSA"
private_key_rsa_bits = 4096

instance_keypair = "Dev_Key"

*---------------------------------------------------------------------------------------------------------*
target_group_name = "Dev-Salary-TG"
target_group_port = 80
target_group_protocol = "HTTP"
TG_vpc_id = "vpc-0ebc6865d6c6a5460" // dev vpc id
health_check_path = "/api/v1/salary/health"
health_check_port = "traffic-port"
health_check_interval = 30
health_check_timeout = 5
health_check_healthy_threshold = 5
health_check_unhealthy_threshold = 2

