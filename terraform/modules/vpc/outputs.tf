output "vpc_id" {
    value = aws_vpc.main.id
}

output "public_subnet_ids" {

    value = [for k, v in aws_subnet.set : aws_subnet.set[k].id if aws_subnet.set[k].map_public_ip_on_launch == true]
}

# example below:

#    value = [for a in var.objects : upper(a) if substr(a,0,5) != "lower"]
# subnet_ids = [for k, v in aws_subnet.private : aws_subnet.private[k].id]