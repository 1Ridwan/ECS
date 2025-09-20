# create vpc

resource "aws_vpc" "main" {
  cidr_block = var.base_cidr
  region = var.vpc_region
  tags = {
    Name = "main"
  }
}

# create subnets

#resource "aws_subnet" "set" {
 # for_each    = { for subnet in var.subnet_objects : subnet.name => subnet }
  #vpc_id     = aws_vpc.main.id
  #cidr_block = each.value.cidr_block
  #availability_zone = each.value.availability_zone
  #map_public_ip_on_launch = each.value.map_public_ip_on_launch
  #tags = {
   # Name = each.key
  #}
#}

resource "aws_subnet" "set" {
  count             = var.subnet_count
  vpc_id           = aws_vpc.main.id
  cidr_block       = cidrsubnet(var.vpc_cidr, 2, count.index)
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "Subnet-${count.index}"
  }
}

# cidr subnet ?

# Create internet gateway

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main-igw"
  }
}

# Create NAT gateway in public subnets

resource "aws_nat_gateway" "public1" {
  allocation_id = aws_eip.one.id
  subnet_id     = aws_subnet.set[0].id

  tags = {
    Name = "NAT-gw-az1" # need to configure this properly so its automatic detect which az, using subnet map
  }

  depends_on = [aws_internet_gateway.main]
  }

  resource "aws_nat_gateway" "public2" {
  allocation_id = aws_eip.two.id
  subnet_id     = aws_subnet.set[1].id

  tags = {
    Name = "NAT-gw-az2" # need to configure this properly so its automatic detect which az, using subnet map
  }

  depends_on = [aws_internet_gateway.main]
}

resource "aws_eip" "one" {
  domain   = "vpc"
}

resource "aws_eip" "two" {
  domain   = "vpc"
}