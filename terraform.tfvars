project_name                   = "orieja"
project_phase_name             = "orieja-dev"
region                         = "eu-west-3"
vpc_cidr                       = "10.0.0.0/16"
user_arn                       = "arn:aws:iam::940373101182:user/terraform"
enable_dns_support             = "true"
enable_dns_hostnames           = "true"
# enable_classiclink             = "false"
# enable_classiclink_dns_support = "false"
public_subnets                 = ["10.0.1.0/24", "10.0.2.0/24"]
compute_private_subnets        = ["10.0.3.0/24", "10.0.4.0/24"]
data_private_subnets           = ["10.0.5.0/24", "10.0.6.0/24"]
root_domain_name               = "orieja.com.ng"
domain_subnet_1                = "wordpress.orieja.com.ng"
domain_subnet_2                = "tooling.orieja.com.ng"
# my_s3_bucket                   = "femmy-dev-terraform-bucket"
environment                    = "production"
  ami_base        = "ami-08284eb384608e0ef"
  ami_web         = "ami-08677f0324bb83377"
# account_no      = "940373101182"
master-username = "admin"
master-password = "PassWord"
db_name         = "wordpress"
keypair         = "terra_16"
access_point    = ["tooling", "wordpress"]
tags = {
  Enviroment      = "production"
  Owner-Email     = "femi@strangenig.com"
  Managed-By      = "terraform"
  Billing-Account = "940373101182"
}

max_size_asg = {
  bastion   = 2
  nginx     = 2
  tooling   = 2
  wordpress = 2
}

min_size_asg = {
  bastion   = 1
  nginx     = 1
  tooling   = 1
  wordpress = 1
}

health_grace_period_asg = {
  bastion   = 300
  nginx     = 300
  tooling   = 300
  wordpress = 300
}

capacity_asg = {
  bastion   = 1
  nginx     = 1
  tooling   = 1
  wordpress = 1
}

  # instance_type-btn               = "t2.micro"
  # min_size_btn                    = 2
  # max_size_btn                    = 2
  # instance_type-ngx               = "t2.micro"
  # min_size_ngx                    = 2
  # max_size_ngx                    = 2
  # instance_type-wps               = "t2.micro"
  # min_size_wps                    = 2
  # max_size_wps                    = 2 
  # instance_type-tlg               = "t2.micro"
  # min_size_tlg                    = 2
  # max_size_tlg                    = 2