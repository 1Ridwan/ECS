variable "vpc_cidr_block" { type = string }
variable "vpc_region" { type = string }

variable "subnet_objects" {
type = list(object({
    cidr_block = string
    availability_zone = string
    map_public_ip_on_launch = bool
    name = string
  }))
}

variable "public_subnet_ids" { type = list(string )}