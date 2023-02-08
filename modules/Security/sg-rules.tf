# security group for alb, to allow acess from any where for HTTP and HTTPS traffic
resource "aws_security_group_rule" "inbound_public-alb_http" {
    type                    = "ingress"
    from_port               = 80
    to_port                 = 80
    protocol                = "tcp"
    cidr_blocks             = ["0.0.0.0/0"]
    security_group_id       = aws_security_group.ACS["publicALB-sg"].id
}

resource "aws_security_group_rule" "inbound_public-alb_https" {
    type                    = "ingress"
    from_port               = 443
    to_port                 = 443
    protocol                = "tcp"
    cidr_blocks             = ["0.0.0.0/0"]
    security_group_id       = aws_security_group.ACS["publicALB-sg"].id
}

# security group for bastion, to allow access into the bastion host from your IP
resource "aws_security_group_rule" "inbound_bastion_ssh" {
    type                    = "ingress"
    from_port               = 22
    to_port                 = 22
    protocol                = "tcp"
    cidr_blocks             = ["0.0.0.0/0"]
    security_group_id       = aws_security_group.ACS["bastion-sg"].id
}

#security group for nginx reverse proxy, to allow access only from the external load balancer and bastion instance
resource "aws_security_group_rule" "public-alb_nginx_https" {
    type                     = "ingress"
    from_port                = 443
    to_port                  = 443
    protocol                 = "tcp"
    source_security_group_id = aws_security_group.ACS["publicALB-sg"].id
    security_group_id        = aws_security_group.ACS["nginx-sg"].id
}

resource "aws_security_group_rule" "bastion_nginx_ssh" {
    type                     = "ingress"
    from_port                = 22
    to_port                  = 22
    protocol                 = "tcp"
    source_security_group_id = aws_security_group.ACS["bastion-sg"].id
    security_group_id        = aws_security_group.ACS["nginx-sg"].id
}

# security group for internal alb, to have access only from nginx reverse proxy server
resource "aws_security_group_rule" "nginx_private-alb_http" {
    type                     = "ingress"
    from_port                = 443
    to_port                  = 443
    protocol                 = "tcp"
    source_security_group_id = aws_security_group.ACS["nginx-sg"].id
    security_group_id        = aws_security_group.ACS["privateALB-sg"].id
}

# security group for webservers, to have access only from the internal load balancer and bastion instance
resource "aws_security_group_rule" "private-alb_webserver_https" {
    type                     = "ingress"
    from_port                = 443
    to_port                  = 443
    protocol                 = "tcp"
    source_security_group_id = aws_security_group.ACS["privateALB-sg"].id
    security_group_id        = aws_security_group.ACS["webserver-sg"].id
}

resource "aws_security_group_rule" "bastion_webserver_ssh" {
    type                     = "ingress"
    from_port                = 22
    to_port                  = 22
    protocol                 = "tcp"
    source_security_group_id = aws_security_group.ACS["bastion-sg"].id
    security_group_id        = aws_security_group.ACS["webserver-sg"].id
}

resource "aws_security_group_rule" "efs_webserver_nfs" {
    type                     = "ingress"
    from_port                = 2049
    to_port                  = 2049
    protocol                 = "tcp"
    source_security_group_id = aws_security_group.ACS["datalayer-sg"].id
    security_group_id        = aws_security_group.ACS["webserver-sg"].id
}

resource "aws_security_group_rule" "rds_webserver_mysql" {
    type                     = "ingress"
    from_port                = 3306
    to_port                  = 3306
    protocol                 = "tcp"
    source_security_group_id = aws_security_group.ACS["datalayer-sg"].id
    security_group_id        = aws_security_group.ACS["webserver-sg"].id
}

# security group for datalayer to allow traffic from websever on nfs and mysql
resource "aws_security_group_rule" "webserver_efs_nfs" {
    type                     = "ingress"
    from_port                = 2049
    to_port                  = 2049
    protocol                 = "tcp"
    source_security_group_id = aws_security_group.ACS["webserver-sg"].id
    security_group_id        = aws_security_group.ACS["datalayer-sg"].id
}

resource "aws_security_group_rule" "webserver_rds_mysql" {
    type                     = "ingress"
    from_port                = 3306
    to_port                  = 3306
    protocol                 = "tcp"
    source_security_group_id = aws_security_group.ACS["webserver-sg"].id
    security_group_id        = aws_security_group.ACS["datalayer-sg"].id
}
