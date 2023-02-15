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
  source                    = "./modules/ALB"
  project_phase_name        = var.project_phase_name
  vpc_id                    = module.VPC.vpc_id
  publicALB-sg              = module.security.publicALB-sg
  privateALB-sg             = module.security.privateALB-sg
  public_subnets-1          = module.VPC.public_subnets-1
  public_subnets-2          = module.VPC.public_subnets-2
  compute_private_subnets-1 = module.VPC.compute_private_subnets-1
  compute_private_subnets-2 = module.VPC.compute_private_subnets-2
  root_domain_name          = var.root_domain_name
  domain_subnet_1           = var.domain_subnet_1
  domain_subnet_2           = var.domain_subnet_2
  #private_sbn = module.VPC.Compute_PrivateSubnet-[*]
  # public-sbn-2       = module.VPC.PublicSubnet-2
  # compute-private-sbn-2   = module.VPC.Compute_PrivateSubnet-2
  # load_balancer_type = "application"
  # ip_address_type    = "ipv4"
}

module "security" {
  source       = "./modules/Security"
  vpc_id       = module.VPC.vpc_id
  project_name = "orieja"
}

module "AutoScaling" {
  source                  = "./modules/Autoscaling"
  ami_base                = var.ami_base #"ami-08284eb384608e0ef"
  ami_web                 = var.ami_web  #"ami-08677f0324bb83377"
  instance_type-btn       = "t2.micro"
  min_size_btn            = 2
  max_size_btn            = 2
  instance_type-ngx       = "t2.micro"
  min_size_ngx            = 2
  max_size_ngx            = 2
  instance_type-wps       = "t2.micro"
  min_size_wps            = 2
  max_size_wps            = 2
  instance_type-tlg       = "t2.micro"
  min_size_tlg            = 2
  max_size_tlg            = 2
  health_grace_period_asg = var.health_grace_period_asg
  capacity_asg            = var.capacity_asg
  #health_check_grace_period = var.health_grace_period_asg
  web-sg            = module.security.web-sg
  bastion-sg        = module.security.bastion-sg
  nginx-sg          = module.security.nginx-sg
  wordpress-alb-tgt = module.ALB.wordpress-TG
  nginx-alb-tgt     = module.ALB.nginx-TG
  tooling-alb-tgt   = module.ALB.tooling-TG
  # instance_profile          = module.VPC.instance_profile
  public_subnets-1          = module.VPC.public_subnets-1
  public_subnets-2          = module.VPC.public_subnets-2
  compute_private_subnets-1 = module.VPC.compute_private_subnets-1
  compute_private_subnets-2 = module.VPC.compute_private_subnets-2
  instance_profile          = module.VPC.instance_profile
  project_phase_name        = var.project_phase_name
  keypair                   = var.keypair
  # list_of_az                      = module.VPC.list_of_az[*]
}

# # Module for Elastic Filesystem; this module will create elastic file system in the webservers availablity
# # zone and allow traffic from the webservers

module "EFS" {
  source                 = "./modules/EFS"
  data_private_subnets-1 = module.VPC.data_private_subnets-1
  data_private_subnets-2 = module.VPC.data_private_subnets-2
  datalayer-sg           = module.security.datalayer-sg
  access_point           = var.access_point
  user_arn               = var.user_arn
  # account_no   = var.account_no
}

# RDS module; this module will create the RDS instance in the private subnet
module "RDS" {
  source                 = "./modules/RDS"
  master-password        = var.master-password
  master-username        = var.master-username
  db_name                = var.db_name
  datalayer-sg           = module.security.datalayer-sg
  data_private_subnets-1 = module.VPC.data_private_subnets-1
  data_private_subnets-2 = module.VPC.data_private_subnets-2
}

# The Module creates instances for jenkins, sonarqube abd jfrog
module "compute" {
  source           = "./modules/compute"
  ami_base         = var.ami_base #"ami-08284eb384608e0ef"
  project_name     = var.project_name
  public_subnets-1 = module.VPC.public_subnets-1
  compute-sg       = module.security.ACS-sg
  keypair          = var.keypair
}