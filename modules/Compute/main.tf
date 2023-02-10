# create instance for jenkins
resource "aws_instance" "jenkins" {
  ami                         = var.ami["ami-base"]
  instance_type               = "t2.micro"
  subnet_id                   = var.public_subnets[0]
  vpc_security_group_ids      = var.sg-compute
  associate_public_ip_address = true
  key_name                    = var.keypair

 tags = merge(
    var.tags,
    {
      Name = format("%s-ACS-jenkins", var.project_name)
    },
  )
}


#create instance for sonarqube
resource "aws_instance" "sonarqube" {
  ami                         = var.ami["ami-base"]
  instance_type               = "t2.medium"
  subnet_id                   = var.public_subnets[0]
  vpc_security_group_ids      = var.sg-compute
  associate_public_ip_address = true
  key_name                    = var.keypair


   tags = merge(
    var.tags,
    {
      Name = format("%s-ACS-sonarqube", var.project_name)
    },
  )
}

# create instance for artifactory
resource "aws_instance" "artifactory" {
  ami                         = var.ami["ami-base"]
  instance_type               = "t2.medium"
  subnet_id                   = var.subnets-compute
  vpc_security_group_ids      = var.sg-compute
  associate_public_ip_address = true
  key_name                    = var.keypair


  tags = merge(
    var.tags,
    {
      Name = format("%s-ACS-artifactory", var.project_name)
    },
  )
}