output "vpc_id" {
    value = aws_vpc.main.id
}

output "igw_id" {
    value = aws_internet_gateway.main.id
}

output "nat_gateway_id_one" {
    value = aws_nat_gateway.public1.id
}

output "nat_gateway_id_two" {
    value = aws_nat_gateway.public2.id
}

output "public_subnet_ids" {
  value = [
    aws_subnet.set[0].id,
    aws_subnet.set[1].id
  ]
}

output "private_subnet_ids" {
  value = [
    aws_subnet.set[2].id,
    aws_subnet.set[3].id
  ]
}



# example below:

#    value = [for a in var.objects : upper(a) if substr(a,0,5) != "lower"]
# subnet_ids = [for k, v in aws_subnet.private : aws_subnet.private[k].id]