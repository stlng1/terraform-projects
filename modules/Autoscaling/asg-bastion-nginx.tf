#Get list of availability zones
data "aws_availability_zones" "available" {
  state = "available"
}

resource "random_shuffle" "az_list" {
  input = [data.aws_availability_zones.available.names]
}

# ---- Autoscaling for bastion  hosts
resource "aws_autoscaling_group" "bastionASG" {
  name                      = "${var.project_phase_name}-bastionASG"
  max_size                  = var.max_size_btn
  min_size                  = var.min_size_btn
  health_check_grace_period = var.health_grace_period_asg["bastion"]
  health_check_type         = "ELB"
  desired_capacity          = var.capacity_asg["bastion"]

  vpc_zone_identifier = [
    var.public_sbn-1,
    var.public_sbn-2
  ]

  launch_template {
    id      = aws_launch_template.bastion-launch-template.id
    version = "$Latest"
  }
 
  tag {
    key                 = "name"
    value               = "${var.project_phase_name}-bastionASG-instance-launch"
    propagate_at_launch = true
  }
  
}

# ------ Autoscaling group for reverse proxy nginx ---------

resource "aws_autoscaling_group" "nginxASG" {
  name                      = "nginxASG"
  max_size                  = var.max_size_ngx
  min_size                  = var.min_size_ngx
  health_check_grace_period = var.health_grace_period_asg["nginx"]
  health_check_type         = "ELB"
  desired_capacity          = var.capacity_asg["nginx"]

  vpc_zone_identifier = [
    var.public_sbn-1,
    var.public_sbn-2
  ]

  launch_template {
    id      = aws_launch_template.nginx-launch-template.id
    version = "$Latest"
  }

  tag {
    key                 = "name"
    value               = "${var.project_phase_name}-nginxASG-instance-launch"
    propagate_at_launch = true
  }

}

# attaching autoscaling group of nginx to external load balancer
resource "aws_autoscaling_attachment" "asg_attachment_nginx" {
  autoscaling_group_name = aws_autoscaling_group.nginxASG.id
  alb_target_group_arn   = var.nginx-alb-tgt
}