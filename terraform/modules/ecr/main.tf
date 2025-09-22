resource "aws_ecr_repository" "main" {
  name                 = "main-ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

# pull the latest image from the repo main-ecr so we always
# use the latest image in our ECS task definition

data "aws_ecr_image" "app" {
  repository_name = aws_ecr_repository.main.name
  image_tag = "latest"
}

# delete all tagged images after 7 days

resource "aws_ecr_lifecycle_policy" "my_policy" {
  repository = aws_ecr_repository.main.name

    policy = <<EOF
  {
      "rules": [
          {
              "rulePriority": 1,
              "description": "Expire images older than 7 days",
              "selection": {
                  "tagStatus": "tagged",
                  "countType": "sinceImagePushed",
                  "countUnit": "days",
                  "countNumber": 7
              },
              "action": {
                  "type": "expire"
              }
          }
      ]
  }
  EOF
  }