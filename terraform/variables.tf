variable "base_cidr" {
  type = string
  default = "10.0.0.0/24"
  description = "the base cidr block that makes up the vpc private network addresses"
}

variable "vpc_region" { 
  type = string
  default = "eu-west-2" 
  description = "the region the vpc is created in"
  }

variable "availability_zones" { 
  type = list(string) 
  default = ["eu-west-2a", "eu-west-2b", "eu-west-2a", "eu-west-2b"]
  description = "a list of availability zones used to assign subnets and nat gateway to the corresponding AZ"
  }

variable "subnet_count" {
  type = number
  default = 4
  description = "number of subnets to be created in the VPC"
}

variable "environment" {
  type = string
  default = "dev"
}

variable "apex_domain" {
  type = string
  default = "ridwanprojects.com"
  description = "Hosted zone name for my apex domain"
}

variable "sub_domain" {
  type = string
  default = "tm.ridwanprojects.com"
  description = "Hosted zone name for my sub domain"
}

variable "container_port" {
    type = number
    description = "the port for my container"
    default = 8080
}