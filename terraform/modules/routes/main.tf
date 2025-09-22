# public subnet route table

resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }
}

resource "aws_route_table_association" "public_rtb" {
  count = 2
  subnet_id = var.public_subnet_ids[count.index]
  route_table_id = aws_route_table.public.id
}

# private subnet route tables
# private subnet in az1 must be routed to natgw in az1 (vice versa for az2)

resource "aws_route_table" "private1" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = var.nat_gateway_id_one
  }
}

resource "aws_route_table" "private2" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = var.nat_gateway_id_two
  }
}

# assign route tables to corresponding private subnet in correct az

resource "aws_route_table_association" "private1" {
  subnet_id      = var.private_subnet_ids[0]
  route_table_id = aws_route_table.private1.id
}

resource "aws_route_table_association" "private2" {
  subnet_id      = var.private_subnet_ids[1]
  route_table_id = aws_route_table.private2.id
}