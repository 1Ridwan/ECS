# vpc module outputs

output "public_subnet_ids" {
    value = module.vpc.public_subnet_ids
    description = "a list of subnet ids that belond to the public subnets in my vpc"
}

output "private_subnet_ids" {
    value = module.vpc.private_subnet_ids
    description = "a list of subnet ids that belond to the private subnets in my vpc"
}

output "vpc_id" {
    value = module.vpc.vpc_id
    description = "the id of the vpc"
}

output "nat_gateway_id_one" {
    value = module.vpc.nat_gateway_id_one
    description = "the nat gateway id of the first natgw"
}

output "nat_gateway_id_two" {
    value = module.vpc.nat_gateway_id_two
    description = "the nat gateway id of the second natgw"
}

# alb module outputs


output "target_group_arn" {
    value = module.alb.target_group_arn
    description = "arn of alb target group that is used by ecs module"
}

# alb outputs for route53 use

output "alb_dns_name" {
    value = module.alb.alb_dns_name
    description = "alb dns name to be used by route53 module"
}

output "alb_zone_id" {
    value = module.alb.alb_zone_id
    description = "alb zone id to be used by route53 module"

}

# sg module outputs

output "alb_sg" {
    value = module.sg.alb_sg_id
    description = "alb security group to be used by alb module"
}

# ecr module outputs

output "ecr_repo_url" {
    value = module.ecr.ecr_repo_url
}

output "ecr_repo_arn" {
    value = module.ecr.ecr_repo_arn
}

output "ecr_registry_id" {
    value = module.ecr.ecr_registry_id
}

output "ecr_name" {
    value = module.ecr.ecr_name 
}

output "ecr_image_digest" {
    value = module.ecr_image_digest
}


# ecs module outputs

output "ecs_service_sg_id" {
    value = module.sg.ecs_service_sg_id
}


# acm outputs

output "certificate_arn" {
    value = module.acm.certificate_arn
}


output "certificate_dvos" {
    value = [module.acm.certificate_dvos]
}
