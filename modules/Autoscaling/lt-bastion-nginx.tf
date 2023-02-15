#launch template for bastion
resource "aws_launch_template" "bastion-launch-template" {
 image_id                = var.ami_base
  instance_type          = var.instance_type-btn
  vpc_security_group_ids = [var.bastion-sg]

  iam_instance_profile {
    name = var.instance_profile
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


# launch template for nginx

resource "aws_launch_template" "nginx-launch-template" {
  image_id               = var.ami_base
  instance_type          = var.instance_type-ngx
  vpc_security_group_ids = [var.nginx-sg]

  iam_instance_profile {
    name = var.instance_profile
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