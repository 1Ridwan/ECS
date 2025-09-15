# route tabeles

resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }

    route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }

  tags = {
    Name = "public"
  }
}

# assign route tables to public subnets

resource "aws_route_table_association" "public1" {
  subnet_id      = var.public_subnet_ids[0]
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public2" {
  subnet_id      = var.public_subnet_ids[1]
  route_table_id = aws_route_table.public.id
}

# Create route tables for private subnets



resource "aws_route_table" "private1" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = var.nat_gateway_id_one
  }
  tags = {
    Name = "private1"
  }
}

resource "aws_route_table" "private2" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = var.nat_gateway_id_two
  }
  tags = {
    Name = "private2"
  }
}


# assign route tables to private subnets

resource "aws_route_table_association" "private1" {
  subnet_id      = var.private_subnet_ids[0]
  route_table_id = aws_route_table.private1.id
}

resource "aws_route_table_association" "private2" {
  subnet_id      = var.private_subnet_ids[1]
  route_table_id = aws_route_table.private2.id
}

# route table for NAT gateway in public subnet

resource "aws_route_table" "nat_gateway" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }
  tags = {
    Name = "natgw-route-table"
  }
}

# associate route tables for both nat gateways

resource "aws_route_table_association" "nat_gateway1" {
  subnet_id      = var.public_subnet_ids[0]
  route_table_id = aws_route_table.nat_gateway.id
}


resource "aws_route_table_association" "nat_gateway2" {
  subnet_id      = var.public_subnet_ids[1]
  route_table_id = aws_route_table.nat_gateway.id
}