variable "base_cidr" { type = string }

variable "vpc_region" { type = string }

variable "subnet_objects" {
type = list(object({
    cidr_block = string
    availability_zone = string
    map_public_ip_on_launch = bool
    name = string
    subnet_id = string
  }))
}

variable "availability_zones" { type = list(string) }

variable "subnet_count" {
  type = number
  description = "(optional) describe your variable"
}