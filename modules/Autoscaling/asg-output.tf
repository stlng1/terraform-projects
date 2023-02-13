#------------------------------------------------------------------------------
# AWS EC2 AUTO SCALING GROUP
#------------------------------------------------------------------------------

# output "PublicIP" {
#   description = "Public IP of EC2 instance"
#   value       = aws_instance.project_front_end[*].public_ip
# }

# output "lc_name" {
#   description = "The name of the launch configuration."
#   value       = aws_launch_configuration.lc.name
# }

# output "lc_id" {
#   description = "The ID of the launch configuration."
#   value       = aws_launch_configuration.lc.id
# }


output "bastion_asg_id" {
  description = "The autoscaling group id."
  value       = aws_autoscaling_group.bastionASG.id
}

output "nginx_asg_id" {
  description = "The autoscaling group id."
  value       = aws_autoscaling_group.nginxASG.id
}

output "wordpress_asg_id" {
  description = "The autoscaling group id."
  value       = aws_autoscaling_group.wordpressASG.id
}

output "tooling_asg_id" {
  description = "The autoscaling group id."
  value       = aws_autoscaling_group.toolingASG.id
}

output "bastion_asg_arn" {
  description = "The ARN for this AutoScaling Group."
  value       = aws_autoscaling_group.bastionASG.arn
}

output "nginx_asg_arn" {
  description = "The ARN for this AutoScaling Group."
  value       = aws_autoscaling_group.nginxASG.arn
}

output "tooling_asg_arn" {
  description = "The ARN for this AutoScaling Group."
  value       = aws_autoscaling_group.toolingASG.arn
}

output "wordpress_asg_arn" {
  description = "The ARN for this AutoScaling Group."
  value       = aws_autoscaling_group.wordpressASG.arn
}

# output "asg_availability_zones" {
#   description = "The availability zones of the autoscale group."
#   value       = aws_autoscaling_group.asg.availability_zones
# }

output "bastion_asg_min_size" {
  description = "The minimum size of the bastion autoscale group."
  value       = aws_autoscaling_group.bastionASG.min_size
}

output "bastion_asg_max_size" {
  description = "The maximum size of the bastion autoscale group."
  value       = aws_autoscaling_group.bastionASG.max_size
}

output "nginx_asg_min_size" {
  description = "The minimum size of the nginx autoscale group."
  value       = aws_autoscaling_group.nginxASG.min_size
}

output "nginx_asg_max_size" {
  description = "The maximum size of the nginx autoscale group."
  value       = aws_autoscaling_group.nginxASG.max_size
}

output "wordpress_asg_min_size" {
  description = "The minimum size of the wordpress autoscale group."
  value       = aws_autoscaling_group.wordpressASG.min_size
}

output "wordpress_asg_max_size" {
  description = "The maximum size of the wordpress autoscale group."
  value       = aws_autoscaling_group.wordpressASG.max_size
}

output "tooling_asg_min_size" {
  description = "The minimum size of the tooling autoscale group."
  value       = aws_autoscaling_group.toolingASG.min_size
}

output "tooling_asg_max_size" {
  description = "The maximum size of the tooling autoscale group."
  value       = aws_autoscaling_group.toolingASG.max_size
}

# output "asg_default_cooldown" {
#   description = "Time between a scaling activity and the succeeding scaling activity."
#   value       = aws_autoscaling_group.asg.default_cooldown
# }

# output "asg_name" {
#   description = "The name of the autoscale group."
#   value       = aws_autoscaling_group.asg.name
# }

# output "asg_health_check_grace_period" {
#   description = "Time after instance comes into service before checking health."
#   value       = aws_autoscaling_group.asg.health_check_grace_period
# }

# output "asg_health_check_type" {
#   description = "\"EC2\" or \"ELB\". Controls how health checking is done."
#   value       = aws_autoscaling_group.asg.health_check_type
# }

# output "asg_desired_capacity" {
#   description = "The number of Amazon EC2 instances that should be running in the group."
#   value       = aws_autoscaling_group.asg.desired_capacity
# }

# output "asg_launch_configuration" {
#   description = "The launch configuration of the autoscale group."
#   value       = aws_autoscaling_group.asg.launch_configuration
# }

