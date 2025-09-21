output "ecr_repo_url" {
    value = aws_ecr_repository.main.repository_url
}

output "ecr_repo_arn" {
    value = aws_ecr_repository.main.arn
}

output "ecr_registry_id" {
    value = aws_ecr_repository.main.registry_id
}

output "ecr_name" {
    value = aws_ecr_repository.main.name
}

output "ecr_image_digest" {
    value = data.aws_ecr_image.app.image_digest
}
