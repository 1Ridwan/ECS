output "alb_sg_id" {
    value = aws_security_group.allow_http.id
}

output "ecs_service_sg_id" {
    value = aws_security_group.allow_http_traffic_from_alb.id
}
