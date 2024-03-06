region = "us-east-2"
/*--------------- VPC ---------------*/
vpc_tags = {
    Name = "dev-vpc"
    Enviroment = "dev"
    Owner = "harshit"
}

/*--------------- Public Subnets ---------------*/
public_subnets_cidr = ["10.0.0.32/27", "10.0.0.64/27"]

public_subnets_az = ["us-east-2a", "us-east-2b"]

enable_map_public_ip_on_launch = true

public_subnets_tags  = [{
    Name = "public-subnet-01"
    Enviroment = "dev"
    Owner = "harshit"
    }, {
    Name = "public-subnet-02"
    Enviroment = "dev"
    Owner = "harshit"
  }]


/*--------------- Private Subnets ---------------*/

private_subnets_cidr = ["10.0.0.96/27", "10.0.0.128/26", "10.0.0.192/26"]

private_subnets_az = "us-east-2a"

private_subnets_tags = [{
    Name = "frontend-subnet"
    Enviroment = "dev"
    Owner = "harshit"
    }, {
    Name = "backend-subnet"
    Enviroment = "dev"
    Owner = "harshit"
  }, {
    Name = "database-subnet"
    Enviroment = "dev"
    Owner = "harshit"
  }]

/*--------------- IGW ---------------*/

igw_tags = {
    Name = "dev-igw-01"
    Enviroment = "dev"
    Owner = "harshit"
  }

/*--------------- NAT Gateway ---------------*/

nat_tags = {
    Name = "dev-nat-01"
    Enviroment = "dev"
    Owner = "harshit"
  }

/*--------------- # Route Table ---------------*/

public_route_table_tags = {
    Name = "dev-public-RTB-01"
    Enviroment = "dev"
    Owner = "harshit"
  }

private_route_table_tags  = {
    Name = "dev-private-RTB-01"
    Enviroment = "dev"
    Owner = "harshit"
  }

/*--------------- Frontend NACL ---------------*/

frontend_nacl_ingress = [{
    rule_no = 100
    protocol = "tcp"
    cidr_block = "20.0.0.0/28"	
    from_port = 22
    to_port = 22
    action = "allow"
    }, {
    rule_no = 110
    protocol = "tcp"
    cidr_block = "10.0.0.32/27"	
    from_port = 3000	
    to_port = 3000
    action = "allow"
    }, {
    rule_no = 120
    protocol = "tcp"
    cidr_block = "10.0.0.32/27"
    from_port = 22	
    to_port = 22
    action = "allow"
    }, {
    rule_no = 130
    protocol = "tcp"
    cidr_block = "10.0.0.64/27"	
    from_port = 3000
    to_port = 3000
    action = "allow"
    }]

frontend_nacl_egress = [{
    rule_no = 100
    protocol = "tcp"
    cidr_block = "20.0.0.0/28"	
    from_port = 1024 
    to_port = 65535
    action = "allow"
    }, {
    rule_no = 110
    protocol = "tcp"
    cidr_block = "10.0.0.32/27"	
    from_port = 1024
    to_port = 65535
    action = "allow"
    }, {
    rule_no = 120
    protocol = "tcp"
    cidr_block = "10.0.0.64/27"	
    from_port = 1024
    to_port =  65535
    action = "allow"
    }]

frontend_nacl_tags  = {
    Name = "dev-frontend-nacl-01"
    Enviroment = "dev"
    Owner = "harshit"
  }

/*--------------- Backend NACL ---------------*/

# ingress rules

backend_nacl_ingress = [{
    rule_no = 100
    protocol = "tcp"
    cidr_block = "20.0.0.0/28"	
    from_port = 22
    to_port = 22
    action = "allow"
    }, {
    rule_no = 110
    protocol = "tcp"
    cidr_block = "10.0.0.32/27"	
    from_port = 8080
    to_port = 8080
    action = "allow"
    }, {
    rule_no = 120
    protocol = "tcp"
    cidr_block = "10.0.0.192/26"
    from_port = 1024
    to_port = 65535
    action = "allow"
    }, {
    rule_no = 130
    protocol = "tcp"
    cidr_block = "10.0.0.64/27"	
    from_port = 1024
    to_port = 65535
    action = "allow"
    }, {
    rule_no = 140
    protocol = "tcp"
    cidr_block = "10.0.0.32/27"	
    from_port = 22
    to_port = 22
    action = "allow"
    }, {
    rule_no = 150
    protocol = "tcp"
    cidr_block = "10.0.0.32/27"	
    from_port = 1024
    to_port = 65535
    action = "allow"
    }, {
    rule_no = 160
    protocol = "tcp"
    cidr_block = "10.0.0.64/27"	
    from_port = 8080
    to_port = 8080
    action = "allow"
    }]

# egress rules

backend_nacl_egress = [{
    rule_no = 100
    protocol = "tcp"
    cidr_block = "20.0.0.0/28"	
    from_port = 22
    to_port = 22
    action = "allow"
    }, {
    rule_no = 110
    protocol = "tcp"
    cidr_block = "10.0.0.192/26"	
    from_port = 1024
    to_port = 65535
    action = "allow"
    }, {
    rule_no = 120
    protocol = "tcp"
    cidr_block = "20.0.0.0/28"	
    from_port = 1024
    to_port =  65535
    action = "allow"
    }, {
    rule_no = 130
    protocol = "tcp"
    cidr_block = "10.0.0.64/27"	
    from_port = 1024
    to_port =  65535
    action = "allow"
    }, {
    rule_no = 140
    protocol = "tcp"
    cidr_block = "10.0.0.32/27"	
    from_port = 1024
    to_port =  65535
    action = "allow"
    }]

backend_nacl_tags  = {
    Name = "dev-backend-nacl-01"
    Enviroment = "dev"
    Owner = "harshit"
  }

/*--------------- Database NACL ---------------*/

# ingress rules
# private_subnets_cidr = ["10.0.0.96/27", "10.0.0.128/26", "10.0.0.192/26"]

db_nacl_ingress = [{
    rule_no = 100
    protocol = "tcp"
    cidr_block = "20.0.0.0/28"	
    from_port = 22
    to_port = 22
    action = "allow"
    }, {
    rule_no = 110
    protocol = "tcp"
    cidr_block = "10.0.0.32/27"	
    from_port = 22
    to_port = 22
    action = "allow"
    }, {
    rule_no = 120
    protocol = "tcp"
    cidr_block = "10.0.0.128/26"
    from_port = 6379
    to_port = 6379
    action = "allow"
    }, {
    rule_no = 130
    protocol = "tcp"
    cidr_block = "10.0.0.128/26"	
    from_port = 9042
    to_port = 9042
    action = "allow"
    }, {
    rule_no = 140
    protocol = "tcp"
    cidr_block = "10.0.0.128/26"	
    from_port = 5432
    to_port = 5432
    action = "allow"
    }]

# egress rules

db_nacl_egress = [{
    rule_no = 100
    protocol = "tcp"
    cidr_block = "20.0.0.0/28"	
    from_port = 1024
    to_port = 65535
    action = "allow"
    }, {
    rule_no = 110
    protocol = "tcp"
    cidr_block = "10.0.0.128/26"	
    from_port = 1024
    to_port = 65535
    action = "allow"
    }, {
    rule_no = 120
    protocol = "tcp"
    cidr_block = "10.0.0.32/27"	
    from_port = 1024
    to_port =  65535
    action = "allow"
    }]

db_nacl_tags  = {
    Name = "dev-db-nacl-01"
    Enviroment = "dev"
    Owner = "harshit"
  }

/*--------------- ALB Security Group ---------------*/

alb_sg_name = "dev-alb-sg"

alb_sg_description = "Security group for Dev-ALB"

alb_sg_inbound_rules  = [{
      port     = 80
      source   = "0.0.0.0/0" 
      protocol = "tcp"  
    }, {
      port     = 443
      source   = "0.0.0.0/0" 
      protocol = "tcp"  
    }]

alb_sg_outbound_rules  = [
    {
      port     = 0  
      source   = "0.0.0.0/0"
      protocol = "-1"  
    }
  ]

alb_sg_tags = {
    Environment = "dev"
    Owner       = "harshit"
  }

/*--------------- ALB ---------------*/

 alb_deletion_protection = false
 alb_name = "dev-ns-alb"
 elb_type = "application"
 alb_internal = false
 alb_tags = {
    Enviroment = "dev"
    Owner = "harshit"
  }
