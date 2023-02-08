output "publicALB-sg" {
  value = aws_security_group.ACS["publicALB-sg"].id
}


output "privateALB-sg" {
  value = aws_security_group.ACS["privateALB-sg"].id
}


output "bastion-sg" {
  value = aws_security_group.ACS["bastion-sg"].id
}


output "nginx-sg" {
  value = aws_security_group.ACS["nginx-sg"].id
}


output "web-sg" {
  value = aws_security_group.ACS["webserver-sg"].id
}


output "datalayer-sg" {
  value = aws_security_group.ACS["datalayer-sg"].id
}