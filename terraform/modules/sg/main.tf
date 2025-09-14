resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  description = "Allow all incoming HTTP traffic"
  vpc_id      = var.vpc_id

  tags = {
    Name = "allow_http"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.allow_http.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic" {
  security_group_id = aws_security_group.allow_http.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

# security group for ECS service

resource "aws_security_group" "allow_http_traffic_from_alb" {
  name        = "allow_http_from_alb"
  description = "Allow all incoming HTTP traffic from ALB"
  vpc_id      = var.vpc_id

  tags = {
    Name = "allow_http_from_alb"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_from_alb" {
  security_group_id = aws_security_group.allow_http_from_alb.id
  referenced_security_group_id = aws_security_group.allow_http.id
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ecs" {
  security_group_id = aws_security_group.allow_http_traffic_from_alb.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}