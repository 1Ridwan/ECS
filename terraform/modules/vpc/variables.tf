variable "vpc_cidr" { type = string }

variable "vpc_region" { type = string }

variable "subnet_count" { type = number }

variable "availability_zones" { type = list(string) }
