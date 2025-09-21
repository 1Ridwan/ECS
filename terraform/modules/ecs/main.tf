resource "aws_ecs_cluster" "main" {
  name = "ecs-cluster"
}

resource "aws_ecs_service" "main" {
  name            = "web-app-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app_task.arn
  desired_count   = 2
  launch_type = "FARGATE"

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "shiori" # to be updated with the container name
    container_port   = 8080
  }

   network_configuration {
    subnets = var.private_subnet_ids # should use var.pvt_subnet_index_1 / 2
    security_groups = [var.ecs_service_sg_id]
    assign_public_ip = false
   }
}

resource "aws_ecs_task_definition" "app_task" {
  family                   = "kuma"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 512
  memory                   = 1024

  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn      = aws_iam_role.ecs_task_execution_role.arn

container_definitions = jsonencode([
  {
    name      = "shiori"
    image     = "${var.ecr_repo_url}@${var.ecr_image_digest}"
    essential = true

    portMappings = [
      {
        containerPort = 8080
        hostPort = 8080
        protocol      = "tcp"
      }
    ]

    logConfiguration = {
      logDriver = "awslogs",
      options = {
        awslogs-group         = "/ecs/shiori"
        awslogs-region        = var.vpc_region
        awslogs-stream-prefix = "ecs"
      }
    }


  }
])
}

resource "aws_cloudwatch_log_group" "shiori" {
  name              = "/ecs/shiori"
  retention_in_days = 14
}



# TODO: move these to iam module

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecs-task-execution-role"

  # Terraform's "jsonencode" function converts a Terraform expression result to valid JSON syntax.
  
  assume_role_policy = jsonencode({
    
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}