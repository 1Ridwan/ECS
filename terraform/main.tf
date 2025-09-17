module "vpc" {
    source = "./modules/vpc"
    vpc_cidr_block = var.vpc_cidr_block
    vpc_region = var.vpc_region
    subnet_objects = var.subnet_objects
    public_subnet_ids = module.vpc.public_subnet_ids

}

module "alb" {
    source = "./modules/alb"
    vpc_id = module.vpc.vpc_id
    vpc_region = var.vpc_region
    alb_sg = [module.sg.alb_sg_id]
    certificate_arn = module.acm.certificate_arn

    public_subnets_ids = module.vpc.public_subnet_ids
}

module "sg" {
    source = "./modules/sg"
    vpc_id = module.vpc.vpc_id
    vpc_cidr_block = var.vpc_cidr_block
}

module "routes" {
    source = "./modules/routes"
    public_subnet_ids = module.vpc.public_subnet_ids
    private_subnet_ids = module.vpc.private_subnet_ids
    vpc_id = module.vpc.vpc_id
    igw_id = module.vpc.igw_id
    nat_gateway_id_one = module.vpc.nat_gateway_id_one
    nat_gateway_id_two = module.vpc.nat_gateway_id_two
}

module "ecr" {
    source = "./modules/ecr"
    
}

module "ecs" {
    source = "./modules/ecs"
    private_subnet_ids = module.vpc.private_subnet_ids
    ecs_service_sg_id = module.sg.ecs_service_sg_id
    ecr_repo_url = module.ecr.ecr_repo_url
    target_group_arn = module.alb.target_group_arn
    ecr_name = module.ecr.ecr_name
    
}

module "route53" {
    source = "./modules/route53"
    alb_dns_name = module.alb.alb_dns_name
    alb_zone_id = module.alb.alb_zone_id
}


module "acm" {
    source = "./modules/acm"
    
}