# Create a VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  # enable_classiclink             = var.enable_classiclink
  # enable_classiclink_dns_support = var.enable_classiclink_dns_support

  tags = merge(
    var.tags,
    {
      Name = format("%s-vpc", var.project_name)
    },
  )
}

# Get list of availability zones
data "aws_availability_zones" "available" {
  state = "available"
}

# create public subnets
resource "aws_subnet" "PublicSubnet" {
  count                   = length(var.public_subnets)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnets[count.index]
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[count.index]

  tags = merge(
    var.tags,
    {
      Name = "${format("PublicSubnet-%02d", count.index + 1)}"
    }
  )
}

# create private compute subnets
resource "aws_subnet" "Compute_PrivateSubnet" {
  count                   = length(var.compute_private_subnets)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.compute_private_subnets[count.index]
  map_public_ip_on_launch = false
  availability_zone       = data.aws_availability_zones.available.names[count.index]

  tags = merge(
    var.tags,
    {
      Name = "${format("ComputePrivateSubnet-%02d", count.index + 1)}"
    }
  )
}

# create private datalayer subnets
resource "aws_subnet" "Data_PrivateSubnet" {
  count                   = length(var.data_private_subnets)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.data_private_subnets[count.index]
  map_public_ip_on_launch = false
  availability_zone       = data.aws_availability_zones.available.names[count.index]

  tags = merge(
    var.tags,
    {
      Name = "${format("DataPrivateSubnet-%02d", count.index + 1)}"
    }
  )
}


