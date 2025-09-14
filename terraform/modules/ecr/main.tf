resource "aws_ecr_repository" "main" {
  name                 = "main-ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_lifecycle_policy" "my_policy" {
  repository = aws_ecr_repository.main.name

  policy = jsonencode({
    rules = [
      {
        rule_priority = 1
        description   = "Keep only latest 3 images"
        selection     = {
          count_type        = "sinceImagePushed"
          count_number      = 3
          tag_status        = "any"
          # tag_prefix_list   = ["prod"]
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}