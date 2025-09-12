# create vpc

resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr_block
  region = var.vpc_region

  tags = {
    Name = "main"
  }
}

# create public subnets

resource "aws_subnet" "map" {
  for_each    = { for subnet in var.subnet_objects : subnet.name => subnet }
   vpc_id     = aws_vpc.main.id

  tags = {
    Name = each.key
  }
}