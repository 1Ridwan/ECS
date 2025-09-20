variable "base_cidr" { type = string }

variable "vpc_region" { type = string }

variable "availability_zones" { type = list(string) }

variable "subnet_count" {
  type = number
  description = "number of subnets in my VPC"
}