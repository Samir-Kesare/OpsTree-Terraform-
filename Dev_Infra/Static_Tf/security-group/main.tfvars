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
*----------------------------------------------------------------------------------------------------------*
alb_name = "dev-alb"
internal_alb = false
security_groups = ["sg-0c8d69907ebfa1305"]
subnets = ["subnet-0a2270e6f508e903d", "subnet-06a5a25b82ec957cf"]

listener_port = 80

target_group_name = "dev-salary-tg"
target_group_port = 80
vpc_id = "vpc-0ebc6865d6c6a5460"

health_check_path = "/actuator/health"
health_check_port = "traffic-port"
health_check_timeout = 5
health_check_interval = 30
health_check_healthy_threshold = 2
health_check_unhealthy_threshold = 2

listener_rule_priority = 100
listener_rule_host_values = ["example.com"]
