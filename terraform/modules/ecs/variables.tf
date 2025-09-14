variable "app-task" { type = string }
variable "alb_target_group_arn" { type = string }

variable "subnet_objects" {
type = list(object({
    cidr_block = string
    availability_zone = string
    map_public_ip_on_launch = bool
    name = string
  }))
}