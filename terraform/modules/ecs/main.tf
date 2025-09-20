resource "aws_ecs_cluster" "main" {
  name = "ecs-main"
}

resource "aws_ecs_service" "main" {
  name            = "web-app"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app_task.arn
  desired_count   = 2
  launch_type = "FARGATE"

  # iam_role        = aws_iam_role.foo.arn # to be updated with iam_role
  # depends_on      = [aws_iam_role_policy.foo] # to be updated with iam_role_policy

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "app-container" # to be updated with the container name
    container_port   = 80 # to be updated with container port
  }

   network_configuration {
    subnets = var.private_subnet_ids # should use var.pvt_subnet_index_1 / 2
    security_groups = [var.ecs_service_sg_id]
    assign_public_ip = false
   }
}

resource "aws_ecs_task_definition" "app_task" {
  family                   = "main"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn = aws_iam_role.ecs_task_execution_role.arn

  network_mode             = "awsvpc"
  cpu                      = 1024
  memory                   = 2048

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  } 


#     #"image": "${var.ecr_repo_uri}/${var.ecr_name}:main-image"

container_definitions = file("../../../aws/task-definition.json")

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