
variable "target_group_arn" { type = string }

variable "private_subnet_ids" { type = list(string) }

variable "ecs_service_sg_id" { type = string }

variable "ecr_repo_url" {
    type = string
    description = "the url of the ecr repository holding the container images"
}

variable "ecr_name" { type = string }