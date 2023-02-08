output "public_subnets-1" {
  value       = aws_subnet.PublicSubnet[0].id
  description = "The first public subnet in the subnets"
}

output "public_subnets-2" {
  value       = aws_subnet.PublicSubnet[1].id
  description = "The first public subnet"
}


output "compute_private_subnets-1" {
  value       = aws_subnet.Compute_PrivateSubnet[0].id
  description = "The first private subnet"
}

output "compute_private_subnets-2" {
  value       = aws_subnet.Compute_PrivateSubnet[1].id
  description = "The second private subnet"
}


output "data_private_subnets-1" {
  value       = aws_subnet.Data_PrivateSubnet[0].id
  description = "The third private subnet"
}


output "data_private_subnets-2" {
  value       = aws_subnet.Data_PrivateSubnet[1].id
  description = "The fourth private subnet"
}


output "vpc_id" {
  value = aws_vpc.main.id
}


output "instance_profile" {
  value = aws_iam_instance_profile.ip.id
}