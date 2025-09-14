resource "aws_ecs_cluster" "main" {
  name = "ecs-main"
}

resource "aws_ecs_service" "main" {
  name            = "web-app"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app_task.arn
  desired_count   = 2
  launch_type = "FARGATE"
  iam_role        = aws_iam_role.foo.arn # to be updated with iam_role
  depends_on      = [aws_iam_role_policy.foo] # to be updated with iam_role_policy

  load_balancer {
    target_group_arn = var.alb_target_group_arn
    container_name   = "mongo" # to be updated with the container name
    container_port   = 80 # to be updated with container port
  }

   network_configuration {
    subnets = [var.subnet_objects]
    security_groups = [var.ecs_service_security_groups] # create security group for ECS to only allow traffic from ALB?
   }
}

# AmazonECSTaskExecutionRolePolicy required for Fargate to link to ECR





resource "aws_ecs_task_definition" "app_task" {
  family                   = "test"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 1024
  memory                   = 2048
  container_definitions    = <<TASK_DEFINITION # this needs to be updated with container name output var and aws account id, and ecr repo
[
  {
    "name": "app-container",
    "image": "${var.ecr_repo_url}:latest"
  }
]
TASK_DEFINITION

  runtime_platform {
    operating_system_family = "WINDOWS_SERVER_2019_CORE"
    cpu_architecture        = "X86_64"
  }
}