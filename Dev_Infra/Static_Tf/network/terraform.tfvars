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

/*--------------- Public NACL ---------------*/

public_nacl_ingress = [{
    rule_no = 100
    protocol = "tcp"
    cidr_block = "0.0.0.0/0"	
    from_port = 22
    to_port = 22
    action = "allow"
    }, {
    rule_no = 110
    protocol = "tcp"
    cidr_block = "10.0.0.96/27"	
    from_port = 1024	
    to_port = 65535
    action = "allow"
    }]

public_nacl_egress = [{
    rule_no = 100
    protocol = "tcp"
    cidr_block = "0.0.0.0/0"	
    from_port = 22
    to_port = 22
    action = "allow"
    }, {
    rule_no = 110
    protocol = "tcp"
    cidr_block = "10.0.0.96/27"	
    from_port = 1024	
    to_port = 65535
    action = "allow"
    }]

public_nacl_tags  = {
    Name = "dev-public-nacl-01"
    Enviroment = "dev"
    Owner = "harshit"
  }