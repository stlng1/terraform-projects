#create an ALB to balance the traffic between the Instances
resource "aws_lb" "publicALB" {
  name     = "publicALB"
  internal = false
  security_groups = [
    aws_security_group.publicALB-sg.id,
  ]

  subnets = [
    aws_subnet.PublicSubnet[0].id,
    aws_subnet.PublicSubnet[1].id
  ]

  tags = merge(
    var.tags,
    {
      Name = "ACS-publicALB"
    },
  )

  ip_address_type    = "ipv4"
  load_balancer_type = "application"
}

#create a Target Group to point to its targets
resource "aws_lb_target_group" "nginxTG" {
  health_check {
    interval            = 10
    path                = "/healthstatus"
    protocol            = "HTTPS"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }
  name        = "nginxTG"
  port        = 443
  protocol    = "HTTPS"
  target_type = "instance"
  vpc_id      = aws_vpc.main.id
}

#create a Listner for this target Group
resource "aws_lb_listener" "nginx-listner" {
  load_balancer_arn = aws_lb.publicALB.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = aws_acm_certificate.orieja.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nginxTG.arn
  }
}

# ----------------------------
#Internal Load Balancers for webservers
#---------------------------------

resource "aws_lb" "privateALB" {
  name     = "ialb"
  internal = true
  security_groups = [
    aws_security_group.privateALB-sg.id,
  ]

  subnets = [
    aws_subnet.Compute_PrivateSubnet[0].id,
    aws_subnet.Compute_PrivateSubnet[1].id
  ]

  tags = merge(
    var.tags,
    {
      Name = "ACS-privateALB"
    },
  )

  ip_address_type    = "ipv4"
  load_balancer_type = "application"
}

# --- target group  for wordpress -------

resource "aws_lb_target_group" "wordpressTG" {
  health_check {
    interval            = 10
    path                = "/healthstatus"
    protocol            = "HTTPS"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

  name        = "wordpressTG"
  port        = 443
  protocol    = "HTTPS"
  target_type = "instance"
  vpc_id      = aws_vpc.main.id
}

# --- target group for tooling -------

resource "aws_lb_target_group" "toolingTG" {
  health_check {
    interval            = 10
    path                = "/healthstatus"
    protocol            = "HTTPS"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

  name        = "toolingTG"
  port        = 443
  protocol    = "HTTPS"
  target_type = "instance"
  vpc_id      = aws_vpc.main.id
}

# For this aspect a single listener was created for the wordpress which is default,
# A rule was created to route traffic to tooling when the host header changes

resource "aws_lb_listener" "web-listener" {
  load_balancer_arn = aws_lb.privateALB.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = aws_acm_certificate.orieja.arn
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.wordpressTG.arn
  }
}

# listener rule for tooling target

resource "aws_lb_listener_rule" "tooling-listener" {
  listener_arn = aws_lb_listener.web-listener.arn
  priority     = 99

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.toolingTG.arn
  }

  condition {
    host_header {
      values = ["tooling.orieja.com.ng"]
    }
  }
}

