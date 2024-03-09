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
    cidr_blocks = ["sg-09132d5dee9e5e106"] //Dev-Salary-lb-sg ID
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
// Lunch Template
template_name = "Salary-Launch-Template"
template_description = "Launch template for salary api"
instance_type = "t2.micro"
subnet_ID = "subnet-013843b2702f341f4"

AMI_name = "Dev-Salary-AMI"
AMI_Instance_ID = "i-069d5031c2f20d32b"

private_key_algorithm = "RSA"
private_key_rsa_bits = 4096

instance_keypair = "Dev_Key"

*----------------------------------------------------------------------------------------------------------*
// Target Group

target_group_name = "Dev-Salary-TG"
target_group_port = 8080

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

*--------------------------------------------------------------------------------------------------------*
//ALB

alb_name = "Dev-ALB"
internal = false
load_balancer_type = "application"
security_groups = ["sg-09132d5dee9e5e106"]  # Salary-lb-sg ID
subnets = ["subnet-0a2270e6f508e903d", "subnet-06a5a25b82ec957cf"]  # Public subnet IDs

*--------------------------------------------------------------------------------------------------------------*
// Listener Rule
listener_arn = "arn:aws:elasticloadbalancing:us-east-1:975050171850:listener/app/ALB/49e9e7b843170b35/85a562da2e108bf6"
path_pattern = "/api/v1/salary/*"
action_type = "forward"
target_group_arn = "arn:aws:elasticloadbalancing:us-east-1:975050171850:targetgroup/salaryapi/8f778507e433b5f1"

