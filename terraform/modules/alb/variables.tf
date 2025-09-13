variable "vpc_region" { type = string }
variable "vpc_id" { type = string }
variable "alb_sg" { type = list(string) }


variable "public_subnets_ids" { type = list(string) }