output "alb_dns_name" {
  value = aws_lb.publicALB.dns_name
  description = "External load balance arn"
}

output "nginx-TG" {
  description = "nginx target group"
  value = aws_lb_target_group.nginxTG.arn
}


output "wordpress-TG" {
  description = "wordpress target group"
  value       = aws_lb_target_group.wordpressTG.arn
}


output "tooling-TG" {
  description = "tooling target group"
  value       = aws_lb_target_group.toolingTG.arn
}