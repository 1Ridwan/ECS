variable "vpc_cidr_block" { type = string }
variable "vpc_region" { type = string }

variable "subnet_objects" {
type = list(object({
    vpc = string
    cidr_block = string
    availability_zone = string
    name = string
  }))
}