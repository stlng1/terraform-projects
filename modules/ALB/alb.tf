#create an ALB to balance incoming internet traffic between the Instances
resource "aws_lb" "publicALB" {
  name     = "${var.project_phase_name}-publicALB"
  internal = false
  security_groups = [
    var.publicALB-sg,
  ]

  subnets = [
    var.public_subnets-1,
    var.public_subnets-2
  ]

  tags = merge(
    var.tags,
    {
      Name = format("%s-publicALB", var.project_phase_name)
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
  vpc_id      = var.vpc_id
}

#create a Listner for this target Group
resource "aws_lb_listener" "nginx-listener" {
  load_balancer_arn = aws_lb.publicALB.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = aws_acm_certificate.root_domain_certificate.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nginxTG.arn
  }
}

# ----------------------------
#Internal Load Balancers for webservers
#---------------------------------

resource "aws_lb" "privateALB" {
  name     = "${var.project_phase_name}-privateALB"
  internal = true
  security_groups = [
    var.privateALB-sg,
  ]

  subnets = [
    var.compute_private_subnets-1,
    var.compute_private_subnets-2
  ]

  tags = merge(
    var.tags,
    {
      Name = format("%s-privateALB", var.project_phase_name)
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
  vpc_id      = var.vpc_id
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
  vpc_id      = var.vpc_id
}

# For this aspect a single listener was created for the wordpress which is default,
# A rule was created to route traffic to tooling when the host header changes

resource "aws_lb_listener" "web-listener" {
  load_balancer_arn = aws_lb.privateALB.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = aws_acm_certificate.root_domain_certificate.arn
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
      values = ["var.domain_subnet_2"]
    }
  }
}

