module "vpc" {
    source = "./modules/vpc"
    vpc_cidr_block = var.vpc_cidr_block
    vpc_region = var.vpc_region
    subnet_objects = var.subnet_objects
}