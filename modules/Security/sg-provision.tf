# creating dynamic ingress security groups
locals {
  security_groups = {
    publicALB-sg = {
      name        = "${var.project_name}-publicALB-sg"
      description = "public-alb security group"

    }

    # security group for bastion
    bastion-sg = {
      name        = "${var.project_name}-bastion-sg"
      description = "for bastion security group"
    }

    # security group for nginx
    nginx-sg = {
      name        = "${var.project_name}-nginx-sg"
      description = "nginx security group"
    }

    # security group for internal alb
    privateALB-sg = {
      name        = "${var.project_name}-privateALB-sg"
      description = "private-alb security group"
    }


    # security group for webservers
    webserver-sg = {
      name        = "${var.project_name}-webserver-sg"
      description = "webservers security group"
    }


    # security group for data-layer
    datalayer-sg = {
      name        = "${var.project_name}-datalayer-sg"
      description = "data layer security group"
    }

    # security group for compute service group (jenkins, sonar, artifact)
    ACS-sg = {
      name        = "${var.project_name}-ACS-sg"
      description = "compute service security group"
    }
  }
}





