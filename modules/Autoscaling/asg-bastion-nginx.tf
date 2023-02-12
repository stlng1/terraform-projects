# Get list of availability zones
data "aws_availability_zones" "available" {
  state = "available"
}

#launch template for bastion
resource "random_shuffle" "az_list" {
  input = data.aws_availability_zones.available.names
}

resource "aws_launch_template" "bastion-launch-template" {
 image_id                = var.ami["ami_base"]
  instance_type          = var.instance_type-btn
  vpc_security_group_ids = [aws_security_group.bastion-sg.id]

  iam_instance_profile {
    name = aws_iam_instance_profile.ip.id
  }

  key_name = var.keypair

  placement {
    availability_zone = "random_shuffle.az_list.result"
  }

  lifecycle {
    create_before_destroy = true
  }

  tag_specifications {
    resource_type = "instance"

    tags = merge(
      var.tags,
      {
        Name = "${var.project_phase_name}-bastion-launch-template"
      },
    )
  }

  user_data = filebase64("${path.module}/bastion.sh")
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
    aws_subnet.PublicSubnet[0].id,
    aws_subnet.PublicSubnet[1].id
  ]

  launch_template {
    id      = aws_launch_template.bastion-launch-template.id
    version = "$Latest"
  }
 
  tags = merge(
  var.tags, {
    Name = "${var.project_phase_name}-bastionASG-instance-launch"
    propagate_at_launch = true
  }
  )
}


# launch template for nginx

resource "aws_launch_template" "nginx-launch-template" {
  image_id               = var.ami["ami_base"]
  instance_type          = var.instance_type-ngx
  vpc_security_group_ids = [aws_security_group.nginx-sg.id]

  iam_instance_profile {
    name = aws_iam_instance_profile.ip.id
  }

  key_name = var.keypair

  placement {
    availability_zone = "random_shuffle.az_list.result"
  }

  lifecycle {
    create_before_destroy = true
  }

  tag_specifications {
    resource_type = "instance"

    tags = merge(
      var.tags,
      {
        Name = "nginx-launch-template"
      },
    )
  }

  user_data = filebase64("${path.module}/nginx.sh")
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
    aws_subnet.PublicSubnet[0].id,
    aws_subnet.PublicSubnet[1].id
  ]

  launch_template {
    id      = aws_launch_template.nginx-launch-template.id
    version = "$Latest"
  }

  tags = merge(
  var.tags, {
    Name = "${var.project_phase_name}-nginxASG-instance-launch"
    propagate_at_launch = true
  }
  )

}

# attaching autoscaling group of nginx to external load balancer
resource "aws_autoscaling_attachment" "asg_attachment_nginx" {
  autoscaling_group_name = aws_autoscaling_group.nginxASG.id
  alb_target_group_arn   = aws_lb_target_group.nginxTG.arn
}