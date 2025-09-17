output "vpc_id" {
    value = module.vpc.vpc_id
}

output "alb_sg" {
    value = module.sg.alb_sg_id
}

output "public_subnets" {
    value = module.vpc.public_subnets
}

output "public_subnet_ids" {
    value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
    value = module.vpc.private_subnet_ids
}

output "ecr_repo_url" {
    value = module.ecr.ecr_repo_url
}

output "ecr_repo_arn" {
    value = module.ecr.ecr_repo_arn
}

output "ecr_registry_id" {
    value = module.ecr.ecr_registry_id
}

output "target_group_arn" {
    value = module.alb.target_group_arn
}


output "ecs_service_sg_id" {
    value = module.sg.ecs_service_sg_id
}

output "ecr_name" {
    value = module.ecr.ecr_name 
}

output "nat_gateway_id_one" {
    value = module.vpc.nat_gateway_id_one
}

output "nat_gateway_id_two" {
    value = module.vpc.nat_gateway_id_two
}

# alb outputs for route53 use

output "alb_dns_name" {
    value = module.alb.alb_dns_name
}

output "alb_zone_id" {
    value = module.alb.alb_zone_id
}



output "certificate_dvos" {
    value = [module.acm.certificate_dvos]
}


# acm outputs

output "certificate_arn" {
    value = module.acm.certificate_arn
}
