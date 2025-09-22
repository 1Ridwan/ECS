resource "aws_ecs_cluster" "main" {
  name = "ecs-cluster"
  
  setting {
    name = "containerInsights"
    value = "enabled"
   }
}

resource "aws_ecs_service" "main" {
  name            = "web-app-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app_task.arn
  desired_count   = 2
  launch_type = "FARGATE"

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "shiori"
    container_port   = 8080
  }

   network_configuration {
    subnets = var.private_subnet_ids # should use var.pvt_subnet_index_1 / 2
    security_groups = [var.ecs_service_sg_id]
    assign_public_ip = false
   }

}

resource "aws_ecs_task_definition" "app_task" {
  family                   = "shiori"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 512
  memory                   = 1024

  execution_role_arn = var.ecs_task_execution_role_arn
  task_role_arn      = var.ecs_task_execution_role_arn

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
  retention_in_days = 7
}