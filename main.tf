# creating VPC and subnets
module "VPC" {
  source               = "./modules/VPC"
  region               = var.region
  vpc_cidr             = var.vpc_cidr
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  # enable_classiclink   = var.enable_classiclink
  # preferred_number_of_public_subnets  = var.preferred_number_of_public_subnets
  # preferred_number_of_private_subnets = var.preferred_number_of_private_subnets
  # private_subnets                     = [for i in range(1, 8, 2) : cidrsubnet(var.vpc_cidr, 8, i)]
  # public_subnets                      = [for i in range(2, 5, 2) : cidrsubnet(var.vpc_cidr, 8, i)]
  public_subnets          = var.public_subnets[*]
  compute_private_subnets = var.compute_private_subnets[*]
  data_private_subnets    = var.data_private_subnets[*]
  project_phase_name      = var.project_phase_name
  project_name            = var.project_name
}

#Module for Application Load Balancer to create external load balancer and internal load balancer
module "ALB" {
  source             = "./modules/ALB"
  project_phase_name = var.project_phase_name
  vpc_id             = module.VPC.vpc_id
  publicALB-sg       = module.security.publicALB-sg
  privateALB-sg      = module.security.privateALB-sg
  public_sbn-1       = module.VPC.public_subnets-1
  public_sbn-2       = module.VPC.public_subnets-2
  compute_private_sbn-1      = module.VPC.compute_private_subnets-1
  compute_private_sbn-2      = module.VPC.compute_private_subnets-2
  root_domain_name   = var.root_domain_name
  domain_subnet_1    = var.domain_subnet_1
  domain_subnet_2    = var.domain_subnet_2
  #private_sbn = module.VPC.Compute_PrivateSubnet-[*]
  # public-sbn-2       = module.VPC.PublicSubnet-2
  # compute-private-sbn-2   = module.VPC.Compute_PrivateSubnet-2
  # load_balancer_type = "application"
  # ip_address_type    = "ipv4"
}

module "security" {
  source = "./modules/Security"
  vpc_id = module.VPC.vpc_id
  project_name  = "orieja"
}



# module "AutoScaling" {
#   source                      = "./modules/Autoscaling"
#   instance_type-btn               = "t2.micro"
#   min_size_btn                    = 2
#   max_size_btn                    = 2
#   instance_type-ngx               = "t2.micro"
#   min_size_ngx                    = 2
#   max_size_ngx                    = 2
#   instance_type-wps               = "t2.micro"
#   min_size_wps                    = 2
#   max_size_wps                    = 2 
#   instance_type-tlg               = "t2.micro"
#   min_size_tlg                    = 2
#   max_size_tlg                    = 2

#   # health_check_grace_period = var.health_grace_period_asg
#   # sg-web                    = module.security.webserver-sg
#   #bastion-sg      = module.security.bastion-sg
#   # sg-nginx                  = module.security.nginx-sg
#   # wordpress-alb-tgt         = module.ALB.wordpressTG
#   # nginx-alb-tgt             = module.ALB.nginxTG
#   # tooling-alb-tgt           = module.ALB.toolingTG
#   # instance_profile          = module.VPC.instance_profile
#   # public_subnets            = module.VPC.PublicSubnet-[*]
#   # private_subnets           = module.VPC.Compute_PrivateSubnet-[*]
#   #instance_name                      = module.VPC.ip
#   project_phase_name        = var.project_phase_name
#   keypair                   = var.keypair

# }

# # Module for Elastic Filesystem; this module will create elastic file system in the webservers availablity
# # zone and allow traffic from the webservers

# module "EFS" {
#   source       = "./modules/EFS"
#   # private_subnets-1 = module.VPC.Data_PrivateSubnet-[0]
#   # private_subnets-2 = module.VPC.Data_PrivateSubnet-[1]
#   # datalayer-sg      = module.security.datalayer-sg
#   access_point = var.access_point
#   user_arn     = var.user_arn
#   # account_no   = var.account_no
# }

# # RDS module; this module will create the RDS instance in the private subnet
# module "RDS" {
#   source          = "./modules/RDS"
#   master-password     = var.master-password
#   master-username     = var.master-username
#   db_name             = var.db_name
#   # db-sg           = module.security.datalayer-sg
#   # private_subnets = module.VPC.Data_PrivateSubnet-[*]
# }

# # The Module creates instances for jenkins, sonarqube abd jfrog
# module "compute" {
#   source          = "./modules/compute"
#   ami             = var.ami
#   project_name    = var.project_name
#   # public_subnets  = module.VPC.PublicSubnet-[0]
#   # sg-compute      = [module.security.ACS-sg]
#   keypair         = var.keypair
# }