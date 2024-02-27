#---------------------------------EC2 Instance ----------------------------------#



aws_region     = "ap-northeast-1"
instance_ami   = "ami-07c589821f2b353aa"
instance_type  = "t2.medium"
key_name       = "tokyo"
Postgres_Instance_tag      = {
    Name          = "Postgres_Instance"
    Enviroment    = "dev"
    Owner         = "Vikram"
  }
