# ---- Autoscaling for wordpress application
resource "aws_autoscaling_group" "wordpressASG" {
  name                      = "wordpressASG"
  max_size                  = var.max_size_wps
  min_size                  = var.min_size_wps
  health_check_grace_period = var.health_grace_period_asg["wordpress"]
  health_check_type         = "ELB"
  desired_capacity          = var.capacity_asg["wordpress"]
  vpc_zone_identifier = [

    aws_subnet.Compute_PrivateSubnet[0].id,
    aws_subnet.Compute_PrivateSubnet[1].id
  ]

  launch_template {
    id      = aws_launch_template.wordpress-launch-template.id
    version = "$Latest"
  }
  tag {
    key                 = "name"
    value               = "${var.project_phase_name}-wordpressASG-instance-launch"
    propagate_at_launch = true
  }
}

# attatching autoscaling group of  wordpress application to internal loadbalancer
resource "aws_autoscaling_attachment" "asg_attachment_wordpress" {
  autoscaling_group_name = aws_autoscaling_group.wordpressASG.id
  alb_target_group_arn   = aws_lb_target_group.wordpressTG.arn
}


# ---- Autoscaling for tooling -----
resource "aws_autoscaling_group" "toolingASG" {
  name                      = "toolingASG"
  max_size                  = var.max_size_tlg
  min_size                  = var.min_size_tlg
  health_check_grace_period = var.health_grace_period_asg["tooling"]
  health_check_type         = "ELB"
  desired_capacity          = var.capacity_asg["tooling"]

  vpc_zone_identifier = [

    aws_subnet.Compute_PrivateSubnet[0].id,
    aws_subnet.Compute_PrivateSubnet[1].id
  ]

  launch_template {
    id      = aws_launch_template.tooling-launch-template.id
    version = "$Latest"
  }

  tag {
    key                 = "name"
    value               = "${var.project_phase_name}-toolingASG-instance-launch"
    propagate_at_launch = true
  }
}

# attaching autoscaling group of  tooling application to internal loadbalancer
resource "aws_autoscaling_attachment" "asg_attachment_tooling" {
  autoscaling_group_name = aws_autoscaling_group.toolingASG.id
  alb_target_group_arn   = aws_lb_target_group.toolingTG.arn
}