# create vpc

resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr_block
  region = var.vpc_region
  tags = {
    Name = "main"
  }
}

# create subnets

resource "aws_subnet" "set" {
  for_each    = { for subnet in var.subnet_objects : subnet.name => subnet }
  vpc_id     = aws_vpc.main.id
  cidr_block = each.value.cidr_block
  availability_zone = each.value.availability_zone
  map_public_ip_on_launch = each.value.map_public_ip_on_launch

  tags = {
    Name = each.key
  }
}

# Create internet gateway

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main"
  }
}

# Create NAT gateway in public subnets

resource "aws_nat_gateway" "public1" {
  allocation_id = aws_eip.one.id
  subnet_id     = var.public_subnet_ids[0]

  tags = {
    Name = "gw NAT"
  }
  }

  resource "aws_nat_gateway" "public2" {
  allocation_id = aws_eip.two.id
  subnet_id     = var.public_subnet_ids[1]

  tags = {
    Name = "gw NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.main]
}

resource "aws_eip" "one" {
  domain   = "vpc"
}

resource "aws_eip" "two" {
  domain   = "vpc"
}