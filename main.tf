#############################
##creating bucket for s3 backend
#########################

resource "aws_s3_bucket" "terraform-state" {
  bucket        = "femmy-dev-terraform-bucket"
  force_destroy = true
}
resource "aws_s3_bucket_versioning" "version" {
  bucket = aws_s3_bucket.terraform-state.id
  versioning_configuration {
    status = "Enabled"
  }
}
resource "aws_s3_bucket_server_side_encryption_configuration" "first" {
  bucket = aws_s3_bucket.terraform-state.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}


# creating VPC and subnets
module "VPC" {
  source               = "./modules/VPC"
  region               = var.region
  vpc_cidr             = var.vpc_cidr
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_classiclink   = var.enable_classiclink
  # preferred_number_of_public_subnets  = var.preferred_number_of_public_subnets
  # preferred_number_of_private_subnets = var.preferred_number_of_private_subnets
  # private_subnets                     = [for i in range(1, 8, 2) : cidrsubnet(var.vpc_cidr, 8, i)]
  # public_subnets                      = [for i in range(2, 5, 2) : cidrsubnet(var.vpc_cidr, 8, i)]
  public_subnets          = var.public_subnets
  compute_private_subnets = var.compute_private_subnets
  data_private_subnets    = var.data_private_subnets
}

#Module for Application Load Balancer to create external load balancer and internal load balancer
module "ALB" {
  source          = "./modules/ALB"
  vpc_id          = module.VPC.vpc_id
  public-alb-sg   = module.security.publicALB-sg
  private-alb-sg  = module.security.privateALB-sg
  public_subnets  = module.VPC.PublicSubnet-[*]
  private_subnets = module.VPC.Compute_PrivateSubnet-[*]
  # public-sbn-2       = module.VPC.PublicSubnet-2
  # compute-private-sbn-2   = module.VPC.Compute_PrivateSubnet-2
  # load_balancer_type = "application"
  # ip_address_type    = "ipv4"
}

module "security" {
  source = "./modules/Security"
  vpc_id = module.VPC.vpc_id
}


module "AutoScaling" {
  source                    = "./modules/Autoscaling"
  image                     = var.ami
  desired_capacity          = var.capacity_asg
  min_size                  = var.min_size_asg
  max_size                  = var.max_size_asg
  health_check_grace_period = var.health_grace_period_asg
  web-sg                    = module.security.webserver-sg
  bastion-sg                = module.security.bastion-sg
  nginx-sg                  = module.security.nginx-sg
  wordpress-alb-tgt         = module.ALB.wordpressTG
  nginx-alb-tgt             = module.ALB.nginxTG
  tooling-alb-tgt           = module.ALB.toolingTG
  instance_profile          = module.VPC.instance_profile
  public_subnets            = module.VPC.PublicSubnet-[*]
  private_subnets           = module.VPC.Compute_PrivateSubnet-[*]
  keypair                   = var.keypair

}

# Module for Elastic Filesystem; this module will create elastic file system in the webservers availablity
# zone and allow traffic from the webservers

module "EFS" {
  source       = "./modules/EFS"
  efs-subnet-1 = module.VPC.Data_PrivateSubnet-[0]
  efs-subnet-2 = module.VPC.Data_PrivateSubnet-[1]
  efs-sg       = [module.security.datalayer-sg]
  account_no   = var.account_no
}

# RDS module; this module will create the RDS instance in the private subnet

module "RDS" {
  source          = "./modules/RDS"
  db-password     = var.master-password
  db-username     = var.master-username
  db_name         = var.db_name
  db-sg           = module.security.datalayer-sg
  private_subnets = module.VPC.Data_PrivateSubnet-[*]
}

# The Module creates instances for jenkins, sonarqube abd jfrog
module "compute" {
  source          = "./modules/compute"
  ami-jenkins     = var.ami
  ami-sonar       = var.ami
  ami-jfrog       = var.ami
  subnets-compute = module.VPC.PublicSubnet-[0]
  sg-compute      = [module.security.ACS-sg]
  keypair         = var.keypair
}