#alb
# output "alb_dns_name" {
#   value = aws_lb.publicALB.dns_name
#   description = "External load balance arn"
# }

# output "nginx-TG" {
#   description = "nginx target group"
#   value = aws_lb_target_group.nginxTG.arn
# }


# output "wordpress-TG" {
#   description = "wordpress target group"
#   value       = aws_lb_target_group.wordpressTG.arn
# }


# output "tooling-TG" {
#   description = "tooling target group"
#   value       = aws_lb_target_group.toolingTG.arn
# }

#S3

output "s3_bucket_arn" {
  value       = aws_s3_bucket.terraform_state.arn
  description = "The ARN of the S3 bucket"
}

output "dynamodb_table_name" {
  value       = aws_dynamodb_table.terraform_locks.name
  description = "The name of the DynamoDB table"
}

#Autoscaling

# output "asg_min_size" {
#   description = "The minimum size of the autoscale group."
#   value       = aws_autoscaling_group.asg.min_size
# }

# output "asg_max_size" {
#   description = "The maximum size of the autoscale group."
#   value       = aws_autoscaling_group.asg.max_size
# }

# output "asg_name" {
#   description = "The name of the autoscale group."
#   value       = aws_autoscaling_group.asg.name
# }

#Compute

# output "jenkins_public_ip" {
#   description = "Public IP of jenkins EC2 instance"
#   value       = aws_instance.jenkins.public_ip
# }
# output "sonar_public_ip" {
#   description = "Public IP of sonar EC2 instance"
#   value       = aws_instance.sonarqube.public_ip
# }

# output "artifactory_public_ip" {
#   description = "Public IP of artifactory EC2 instance"
#   value       = aws_instance.artifactory.public_ip
# }

# output "jenkins_private_ip" {
#   description = "private IP of jenkins EC2 instance"
#   value       = aws_instance.jenkins.private_ip
# }
# output "sonar_private_ip" {
#   description = "private IP of sonar EC2 instance"
#   value       = aws_instance.sonarqube.private_ip
# }

# output "artifactory_private_ip" {
#   description = "private IP of artifactory EC2 instance"
#   value       = aws_instance.artifactory.private_ip
# }

#EFS

# output "key_id" {
#   value = aws_kms_key.ACS_kms.key_id
# }

#RDS

#security

# output "publicALB-sg" {
#   value = aws_security_group.ACS["publicALB-sg"].id
# }

# output "privateALB-sg" {
#   value = aws_security_group.ACS["privateALB-sg"].id
# }

# output "bastion-sg" {
#   value = aws_security_group.ACS["bastion-sg"].id
# }

# output "nginx-sg" {
#   value = aws_security_group.ACS["nginx-sg"].id
# }

# output "web-sg" {
#   value = aws_security_group.ACS["webserver-sg"].id
# }

# output "datalayer-sg" {
#   value = aws_security_group.ACS["datalayer-sg"].id
# }

#VPC
# output "public_subnets-1" {
#   value       = aws_subnet.PublicSubnet[0].id
#   description = "The first public subnet in the subnets"
# }

# output "public_subnets-2" {
#   value       = aws_subnet.PublicSubnet[1].id
#   description = "The first public subnet"
# }

# output "compute_private_subnets-1" {
#   value       = aws_subnet.Compute_PrivateSubnet[0].id
#   description = "The first private subnet"
# }

# output "compute_private_subnets-2" {
#   value       = aws_subnet.Compute_PrivateSubnet[1].id
#   description = "The second private subnet"
# }

# output "data_private_subnets-1" {
#   value       = aws_subnet.Data_PrivateSubnet[0].id
#   description = "The third private subnet"
# }

# output "data_private_subnets-2" {
#   value       = aws_subnet.Data_PrivateSubnet[1].id
#   description = "The fourth private subnet"
# }

# output "vpc_id" {
#   value = aws_vpc.main.id
# }

# output "instance_profile" {
#   value = aws_iam_instance_profile.ip.id
# }