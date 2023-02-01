terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "eu-west-3"
}

# Create VPC
resource "aws_vpc" "main" {
  cidr_block                     = "10.0.0.0/16"
  enable_dns_support             = true
  enable_dns_hostnames           = true
  enable_classiclink             = false
  enable_classiclink_dns_support = false
  tags = {
    Name            = "main-vpc"
  }
}

# Create public subnets
resource "aws_subnet" "PublicSubnet-1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-west-3a"
  tags = {
    Name            = "PublicSubnet-1"
  }
}

resource "aws_subnet" "PublicSubnet-2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-west-3a"
  tags = {
    Name            = "PublicSubnet-2"
  }
}

# Create private subnets
resource "aws_subnet" "PrivateSubnet-1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "eu-west-3a"

  tags = {
    Name            = "PrivateSubnet-1"
  }
}

resource "aws_subnet" "PrivateSubnet-2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "eu-west-3a"

  tags = {
    Name            = "PrivateSubnet-2"
  }
}

resource "aws_subnet" "PrivateSubnet-3" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.5.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "eu-west-3a"

  tags = {
    Name            = "PrivateSubnet-3"
  }
}

resource "aws_subnet" "PrivateSubnet-4" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.6.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "eu-west-3a"

  tags = {
    Name            = "PrivateSubnet-4"
  }
}
