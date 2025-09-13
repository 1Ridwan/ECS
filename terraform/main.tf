module "vpc" {
    source = "./modules/vpc"
    vpc_cidr_block = var.vpc_cidr_block
    vpc_region = var.vpc_region
    subnet_objects = var.subnet_objects
}

module "alb" {
    source = "./modules/alb"
    vpc_id = module.vpc.vpc_id
    vpc_region = var.vpc_region
    alb_sg = [module.sg.alb_sg_id]

    public_subnets_ids = module.vpc.public_subnet_ids
}

module "sg" {
    source = "./modules/sg"
    vpc_id = module.vpc.vpc_id
    vpc_cidr_block = var.vpc_cidr_block
}