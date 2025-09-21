resource "aws_ecr_repository" "main" {
  name                 = "main-ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

data "aws_ecr_image" "app" {
  repository_name = aws_ecr_repository.main.name
  image_tag = "latest"
}

resource "aws_ecr_lifecycle_policy" "my_policy" {
  repository = aws_ecr_repository.main.name

    policy = <<EOF
  {
      "rules": [
          {
              "rulePriority": 1,
              "description": "Expire images older than 14 days",
              "selection": {
                  "tagStatus": "untagged",
                  "countType": "sinceImagePushed",
                  "countUnit": "days",
                  "countNumber": 14
              },
              "action": {
                  "type": "expire"
              }
          }
      ]
  }
  EOF
  }