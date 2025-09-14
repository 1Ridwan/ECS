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


# resource "aws_route_table" "private" {
 # vpc_id = aws_vpc.main.id

  #route {
   # cidr_block = "0.0.0.0/0"
    #gateway_id = local
  #}
  #tags = {
   # Name = "private"
  #}
#}

# assign route tables to subnets

resource "aws_route_table_association" "public1" {
  subnet_id      = var.public_subnet_ids[0]
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public2" {
  subnet_id      = var.public_subnet_ids[1]
  route_table_id = aws_route_table.public.id
}

#resource "aws_route_table_association" "private" {
#  subnet_id      = [for k, v in aws_subnet.set : aws_subnet.set[k].id if aws_subnet.set[k].map_public_ip_on_launch == false]
#  route_table_id = aws_route_table.private.id
#}