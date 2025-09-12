resource "aws_lb" "main" {
  name               = "main-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  region = "eu-west-2"

  subnets            = [for subnet in aws_subnet.public : subnet.id] # need to create this list

  enable_deletion_protection = true

  tags = {
    name = "main"
  }
}


# this should point to the ECS tasks

resource "aws_lb_target_group" "ecs" {
  name     = "alb-target-group"
  port     = 80
  protocol = "TCP"
  vpc_id   = aws_vpc.main.id

  health_check {
    healthy_threshold = "2"
    internal = "30"
    path - "/"
    port = "80"
    protocol = "HTTP"

  }
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.main.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs.arn
  }
}