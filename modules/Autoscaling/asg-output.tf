#------------------------------------------------------------------------------
# AWS EC2 AUTO SCALING GROUP
#------------------------------------------------------------------------------

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
