# creating dynamic ingress security groups
locals {
  security_groups = {
    publicALB-sg = {
      name        = "publicALB-sg"
      description = "public-alb security group"

    }

    # security group for bastion
    bastion-sg = {
      name        = "bastion-sg"
      description = "for bastion security group"
    }

    # security group for nginx
    nginx-sg = {
      name        = "nginx-sg"
      description = "nginx security group"
    }

    # security group for IALB
    privateALB-sg = {
      name        = "privateALB-sg"
      description = "private-alb security group"
    }


    # security group for webservers
    webserver-sg = {
      name        = "webserver-sg"
      description = "webservers security group"
    }


    # security group for data-layer
    datalayer-sg = {
      name        = "datalayer-sg"
      description = "data layer security group"


    }
  }
}





