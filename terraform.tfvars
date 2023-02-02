project_name                   = "orieja"
region                         = "eu-west-3"
vpc_cidr                       = "10.0.0.0/16"
enable_dns_support             = "true"
enable_dns_hostnames           = "true"
enable_classiclink             = "false"
enable_classiclink_dns_support = "false"
public_subnets                 = ["10.0.1.0/24", "10.0.2.0/24"]
compute_private_subnets        = ["10.0.3.0/24", "10.0.4.0/24"]
data_private_subnets           = ["10.0.5.0/24", "10.0.6.0/24"]
tags = {
  Enviroment      = "production"
  Owner-Email     = "femi@strangenig.com"
  Managed-By      = "terraform"
  Billing-Account = "940373101182"
}
