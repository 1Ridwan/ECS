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
}

