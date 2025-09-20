variable "base_cidr" {
  type = string
  default = "10.0.0.0/24"
  description = "(optional) describe your variable"
}

variable "vpc_region" { 
  type = string
  default = "eu-west-2" 
  }

variable "availability_zones" { 
  type = list(string) 
  default = ["eu-west-2a", "eu-west-2b", "eu-west-2a", "eu-west-2b"]
  }

variable "subnet_count" {
  type = number
  default = 4
  description = "number of subnets in my VPC"
}