output "vpc_id" {
    value = module.vpc.vpc_id
}

output "alb_sg" {
    value = module.sg.alb_sg_id
}

output "public_subnet_ids" {
    value = module.vpc.public_subnet_ids
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