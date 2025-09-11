resource "aws_ecs_cluster" "main" {
  name = "ecs-main"
}


resource "aws_ecs_service" "main" {
  name            = "web-app"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.mongo.arn # to be updated with task definition
  desired_count   = 2
  iam_role        = aws_iam_role.foo.arn # to be updated with iam_role
  depends_on      = [aws_iam_role_policy.foo] # to be updated with iam_role_policy

  load_balancer {
    target_group_arn = aws_lb_target_group.public.arn # to be updated with target group
    container_name   = "mongo" # to be updated with the container name
    container_port   = 80 # to be updated with container port
  }
}