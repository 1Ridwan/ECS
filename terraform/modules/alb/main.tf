resource "aws_lb" "main" {
  name               = "main-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.alb_sg # to be updated with correct list
  region = var.vpc_region

  subnets = var.public_subnets_ids
  enable_deletion_protection = false

  tags = {
    name = "main"
  }
}


# this should point to the ECS tasks

resource "aws_lb_target_group" "ecs" {
  name     = "alb-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "ip"

  health_check {
    healthy_threshold = "2"
    interval = "30"
    path = "/"
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