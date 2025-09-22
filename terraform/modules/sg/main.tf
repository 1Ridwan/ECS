# security group for alb must allow all incoming http/https traffic

resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  description = "Allow all incoming HTTP and HTTPS traffic"
  vpc_id      = var.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.allow_http.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80

  description = "Allow all incoming HTTP traffic"
}

resource "aws_vpc_security_group_ingress_rule" "allow_https" {
  security_group_id = aws_security_group.allow_http.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
  description = "Allow all incoming HTTPS traffic"
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic" {
  security_group_id = aws_security_group.allow_http.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"

  description = "Allow all outgoing traffic"
}

# security group for ECS service must allow all traffic from alb on port 8080

resource "aws_security_group" "allow_http_traffic_from_alb" {
  name        = "allow_traffic_from_alb"
  description = "Allow incoming traffic from ALB"
  vpc_id      = var.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "allow_container_port_from_alb" {
  security_group_id = aws_security_group.allow_http_traffic_from_alb.id
  referenced_security_group_id = aws_security_group.allow_http.id
  from_port         = 8080
  ip_protocol       = "tcp"
  to_port           = 8080

  description = "Allow all incoming traffic on port 8080"
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ecs" {
  security_group_id = aws_security_group.allow_http_traffic_from_alb.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
  description = "Allow all egress so ECS tasks can reach internet"
}
