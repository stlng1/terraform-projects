# create compute-private route table
resource "aws_route_table" "compute-private-rtb" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.tags,
    {
      Name = format("%s-Compute-PrivateRTB", var.project_name)
    },
  )
}

# associate all compute-private subnets to the compute-private route table
resource "aws_route_table_association" "compute-private-subnets-assoc" {
  count          = length(var.compute_private_subnets)
  subnet_id      = element(aws_subnet.Compute_PrivateSubnet.*.id, count.index)
  route_table_id = aws_route_table.compute-private-rtb.id
}

# create datalayer-private route table
resource "aws_route_table" "data-private-rtb" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.tags,
    {
      Name = format("%s-Data-PrivateRTB", var.project_name)
    },
  )
}

# associate all datalayer-private subnets to the datalayer-private route table
resource "aws_route_table_association" "data-private-subnets-assoc" {
  count          = length(var.data_private_subnets)
  subnet_id      = element(aws_subnet.Data_PrivateSubnet.*.id, count.index)
  route_table_id = aws_route_table.data-private-rtb.id
}

# create route table for the public subnets
resource "aws_route_table" "public-rtb" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.tags,
    {
      Name = format("%s-Public-Route-Table", var.project_name)
    },
  )
}

# create route for the public route table and attach the internet gateway
resource "aws_route" "public-rtb-route" {
  route_table_id         = aws_route_table.public-rtb.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# associate all public subnets to the public route table
resource "aws_route_table_association" "public-subnets-assoc" {
  count          = length(var.public_subnets)
  subnet_id      = element(aws_subnet.PublicSubnet.*.id, count.index)
  route_table_id = aws_route_table.public-rtb.id
}