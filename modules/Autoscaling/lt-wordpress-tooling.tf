# launch template for wordpress
resource "aws_launch_template" "wordpress-launch-template" {
  image_id               = var.ami["ami_webservers"]
  instance_type          = var.instance_type-wps
  vpc_security_group_ids = [module.security.web-sg.id]

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



# launch template for tooling
resource "aws_launch_template" "tooling-launch-template" {
  image_id               = var.ami["ami_webservers"]
  instance_type          = var.instance_type-tlg
  vpc_security_group_ids = [module.security.web-sg.id]

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
