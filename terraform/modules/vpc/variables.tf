variable "vpc_cidr_block" { type = string }
variable "vpc_region" { type = string }
variable "subnet1_cidr_block" { type = string }
variable "subnet2_cidr_block" { type = string }
variable "subnet3_cidr_block" { type = string }
variable "subnet4_cidr_block" { type = string }
variable "az1" { type = string }
variable "az2" { type = string }


variable "subnet_objects" {
  type = list(object({
    vpc = string
    cidr_block = string
    availability_zone = string
    name = string
  }))
  default = [
  {
    cidr_block = var.subnet1_cidr_block
    availability_zone = var.az1
    name = "public-az1"
  },
  {
    cidr_block = var.subnet2_cidr_block
    availability_zone = var.az2
    name = "public-az2"
  },
  {
    cidr_block = var.subnet3_cidr_block
    availability_zone = var.az1
    map_public_ip_on_launch = false
    name = "private-az1"
  },
  {
    cidr_block = var.subnet4_cidr_block
    availability_zone = var.az1
    map_public_ip_on_launch = false
    name = "private-az2"
  }
  ]
}
