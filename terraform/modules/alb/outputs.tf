output "alb_arn" {
    value = aws_lb.main.arn
}

output "alb_ip" {
    value = aws.lb.main.alb_ip
}