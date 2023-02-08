#### creating sns topic for all the auto scaling groups
resource "aws_sns_topic" "manager-sns" {
  name = "Default_CloudWatch_Alarms_Topic"
}

#creating notification for all the auto scaling groups
resource "aws_autoscaling_notification" "manager_notifications" {
  group_names = [
    aws_autoscaling_group.bastionASG.name,
    aws_autoscaling_group.nginxASG.name,
    aws_autoscaling_group.wordpressASG.name,
    aws_autoscaling_group.toolingASG.name,
  ]
  notifications = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_TERMINATE",
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
    "autoscaling:EC2_INSTANCE_TERMINATE_ERROR",
  ]

  topic_arn = aws_sns_topic.manager-sns.arn
}

#launch template for bastion
resource "random_shuffle" "az_list" {
  input = data.aws_availability_zones.available.names
}

resource "aws_launch_template" "bastion-launch-template" {
  image_id               = "var.ami"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.bastion-sg.id]

  iam_instance_profile {
    name = aws_iam_instance_profile.ip.id
  }

  key_name = "var.keypair"

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
        Name = "bastion-launch-template"
      },
    )
  }

  user_data = filebase64("${path.module}/bastion.sh")
}

# ---- Autoscaling for bastion  hosts

resource "aws_autoscaling_group" "bastionASG" {
  name                      = "bastionASG"
  max_size                  = var.max_size_bastion-asg
  min_size                  = var.min_size_bastion-asg
  health_check_grace_period = var.health_grace_period_bastion-asg
  health_check_type         = "ELB"
  desired_capacity          = var.capacity_bastion-asg

  vpc_zone_identifier = [
    aws_subnet.PublicSubnet[0].id,
    aws_subnet.PublicSubnet[1].id
  ]

  launch_template {
    id      = aws_launch_template.bastion-launch-template.id
    version = "$Latest"
  }
  tag {
    key                 = "Name"
    value               = "bastionASG-launch-template"
    propagate_at_launch = true
  }

}

# launch template for nginx

resource "aws_launch_template" "nginx-launch-template" {
  image_id               = "var.ami"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.nginx-sg.id]

  iam_instance_profile {
    name = aws_iam_instance_profile.ip.id
  }

  key_name = "var.keypair"

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
  max_size                  = var.max_size_nginx-asg
  min_size                  = var.min_size_nginx-asg
  health_check_grace_period = var.health_grace_period_nginx-asg
  health_check_type         = "ELB"
  desired_capacity          = var.capacity_nginx-asg

  vpc_zone_identifier = [
    aws_subnet.PublicSubnet[0].id,
    aws_subnet.PublicSubnet[1].id
  ]

  launch_template {
    id      = aws_launch_template.nginx-launch-template.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "nginxASG-launch-template"
    propagate_at_launch = true
  }

}

# attaching autoscaling group of nginx to external load balancer
resource "aws_autoscaling_attachment" "asg_attachment_nginx" {
  autoscaling_group_name = aws_autoscaling_group.nginxASG.id
  alb_target_group_arn   = aws_lb_target_group.nginxTG.arn
}