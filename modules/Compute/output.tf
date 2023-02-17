output "jenkins_public_ip" {
  description = "Public IP of jenkins EC2 instance"
  value       = aws_instance.jenkins.public_ip
}
output "sonar_public_ip" {
  description = "Public IP of sonar EC2 instance"
  value       = aws_instance.sonarqube.public_ip
}

output "artifactory_public_ip" {
  description = "Public IP of artifactory EC2 instance"
  value       = aws_instance.artifactory.public_ip
}

output "jenkins_private_ip" {
  description = "private IP of jenkins EC2 instance"
  value       = aws_instance.jenkins.private_ip
}
output "sonar_private_ip" {
  description = "private IP of sonar EC2 instance"
  value       = aws_instance.sonarqube.private_ip
}

output "artifactory_private_ip" {
  description = "private IP of artifactory EC2 instance"
  value       = aws_instance.artifactory.private_ip
}

