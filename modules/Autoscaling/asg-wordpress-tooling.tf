# launch template for wordpress

resource "aws_launch_template" "wordpress-launch-template" {
  image_id               = var.ami["ami_webservers"]
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.webserver-sg.id]

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
        Name = "wordpress-launch-template"
      },
    )

  }

  user_data = filebase64("${path.module}/wordpress.sh")
}

# ---- Autoscaling for wordpress application

resource "aws_autoscaling_group" "wordpressASG" {
  name                      = "wordpressASG"
  max_size                  = var.max_size_asg["wordpress"]
  min_size                  = var.min_size_asg["wordpress"]
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
    key                 = "Name"
    value               = "wordpressASG-launch-template"
    propagate_at_launch = true
  }
}

# attatching autoscaling group of  wordpress application to internal loadbalancer
resource "aws_autoscaling_attachment" "asg_attachment_wordpress" {
  autoscaling_group_name = aws_autoscaling_group.wordpressASG.id
  alb_target_group_arn   = aws_lb_target_group.wordpressTG.arn
}

# launch template for tooling
resource "aws_launch_template" "tooling-launch-template" {
  image_id               = var.ami["ami_webservers"]
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.webserver-sg.id]

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
        Name = "tooling-launch-template"
      },
    )

  }

  user_data = filebase64("${path.module}/tooling.sh")
}

# ---- Autoscaling for tooling -----

resource "aws_autoscaling_group" "toolingASG" {
  name                      = "toolingASG"
  max_size                  = var.max_size_asg["tooling"]
  min_size                  = var.min_size_asg["tooling"]
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
    key                 = "Name"
    value               = "toolingASG-launch-template"
    propagate_at_launch = true
  }
}
# attaching autoscaling group of  tooling application to internal loadbalancer
resource "aws_autoscaling_attachment" "asg_attachment_tooling" {
  autoscaling_group_name = aws_autoscaling_group.toolingASG.id
  alb_target_group_arn   = aws_lb_target_group.toolingTG.arn
}