
// Security_Group
security_group_name = "salary-sg"
description         = "Security group for Salary API"
vpc_id              = "vpc-0c927c113819d1a70"

inbound_rules = [
  {
    port     = 22
    source   = "20.0.0.0/28"   // CIDR for management VPC 
    protocol = "tcp"  
  },
  {
    port     = 22
    security_group_ids = "sg-07aeb9cf56a804770" // OpenVPN-sg
    protocol = "tcp"  
  },
  {
    port     = 8080
    security_group_ids   = "sg-058b1ce89cc72c92f" // Salary-lb-sg
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
AMI_Instance_ID = "i-059e99af9483ecb56"

//Private_key
private_key_algorithm = "RSA"
private_key_rsa_bits = 4096
instance_keypair = "Dev_Key"

//Target_Group
target_group_name = "Dev-Salary-TG"
target_group_port = 80
target_group_protocol = "HTTP"
TG_vpc_id = "vpc-0c927c113819d1a70" // dev vpc id
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
security_groups = ["sg-058b1ce89cc72c92f"]  # Salary-lb-sg ID
subnets = ["subnet-0617c653773732b23", "subnet-0d3ca0eaa48f20939"]  # Public subnet IDs

//Create listener
listener_arn = "arn:aws:elasticloadbalancing:us-east-2:533267160240:listener/app/ALB/be4a2629e59585f7/63e7603c1a41fc34"
path_pattern = "/api/v1/salary/*"
action_type = "forward"
target_group_arn = "arn:aws:elasticloadbalancing:us-east-2:533267160240:targetgroup/salary-ALB/4c049261c77ea55f"

//Configure Auto Scaling group 
asg_name            = "Dev_Salary_ASG"
min_size            = 1
max_size            = 2
desired_capacity    = 1
subnet_ids          = [ "subnet-0617c653773732b23" ]
tag_key             = "Name"
tag_value           = "Dev_Salary_ASG"
propagate_at_launch = false


//Auto Scaling Policies 
scaling_policy_name     = "target-tracking-policy"
policy_type             = "TargetTrackingScaling"
predefined_metric_type  = "ASGAverageCPUUtilization"
target_value            = 50.0
