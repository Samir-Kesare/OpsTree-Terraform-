
// Security_Group
security_group_name = "salary-sg"
description         = "Security group for Salary API"
vpc_id              = "vpc-00631f1bf6539cb88"

inbound_rules = [
  {
    port     = 22
    source   = "20.0.0.0/28"   // CIDR for management VPC 
    protocol = "tcp"  
  },
  {
    port     = 22
    security_group_ids = "sg-045b0ff5f6cfe87fc" // OpenVPN-sg
    protocol = "tcp"  
  },
  {
    port     = 8080
    security_group_ids   = "sg-0f74269626056367c" // Salary-lb-sg
    protocol = "tcp"  
  }
]

outbound_rules = [
  {
    port     = 0 // Allow all ports 
    source   = "0.0.0.0/0"
    protocol = "-1"  // All protocols
  }
]

sg_tags = {
  Name        = "Salary-sg"
  Environment = "Dev"
  Owner       = "Shikha"
}

// Launch_Template
template_name = "Salary-Launch-Template"
template_description = "Launch template for salary api"
instance_type = "t2.micro"
subnet_ID = "subnet-03e34296260c1c84d"

//AMI
AMI_name = "Dev-Salary-AMI"
AMI_Instance_ID = "i-05f8654bfaa45cd56"

//Private_key
private_key_algorithm = "RSA"
private_key_rsa_bits = 4096
instance_keypair = "Dev_Key"

//Target_Group
target_group_name = "Dev-Salary-TG"
target_group_port = 80
target_group_protocol = "HTTP"
TG_vpc_id = "vpc-00631f1bf6539cb88" // dev vpc id
health_check_path = "/api/v1/salary/health"
health_check_port = "traffic-port"
health_check_interval = 30
health_check_timeout = 5
health_check_healthy_threshold = 5
health_check_unhealthy_threshold = 2

//Configure ALB
alb_name = "Dev-ALB"
internal = false
load_balancer_type = "application"
security_groups = ["sg-019094ebc2fc3ac97"]  # Salary-lb-sg ID
subnets = ["subnet-03aa497d8af34753b", "subnet-03e34296260c1c84d"]  # Public subnet IDs

//Create listener
listener_arn = "arn:aws:elasticloadbalancing:us-east-2:975050171850:listener/app/salary-alb/47261e4701ed62b4/7de9e241f1d29732"
path_pattern = "/api/v1/salary/*"
action_type = "forward"
target_group_arn = "arn:aws:elasticloadbalancing:us-east-2:975050171850:targetgroup/salaryapi/9ebffe51875a3570"

//Configure Auto Scaling group 
asg_name            = "Dev_Salary_ASG"
min_size            = 1
max_size            = 2
desired_capacity    = 1
subnet_ids          = [ "subnet-03e34296260c1c84d" ]
tag_key             = "Name"
tag_value           = "Dev_Salary_ASG"
propagate_at_launch = false


//Auto Scaling Policies 
scaling_policy_name     = "target-tracking-policy"
policy_type             = "TargetTrackingScaling"
predefined_metric_type  = "ASGAverageCPUUtilization"
target_value            = 50.0
