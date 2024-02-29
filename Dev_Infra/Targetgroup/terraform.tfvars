*--------------------------------------------------------------------------------------------------*
//Security-Group
security_group_name = "dev-security-group"
security_group_description = "dev security group description"
vpc_id = "vpc-0ebc6865d6c6a5460"
http_port = 8080
ssh_port = 22

ingress_rules = [
  {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["20.0.0.0/28"]
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

*---------------------------------------------------------------------------------------------------*
//Launch-Template
launch_template_name_prefix = "salary-launch-template"
launch_template_description = "Launch Template for Salary application"
instance_type = "t2.micro"
security_group_names = ["salary-sg"]
volume_size = 20
volume_type = "gp2"
*----------------------------------------------------------------------------------------------*
//Target-Group
target_group_name = "salary-target-group"
target_group_port = 80
target_group_protocol = "HTTP"
vpc_id = "vpc-0ebc6865d6c6a5460"
health_check_path = "/health"
health_check_port = "traffic-port"
health_check_interval = 30
health_check_timeout = 5
health_check_healthy_threshold = 2
health_check_unhealthy_threshold = 2
