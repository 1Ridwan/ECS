output "certificate_dvos" {
    value = aws_acm_certificate.main.domain_validation_options
}

output "certificate_arn" {
    value = aws_acm_certificate.main.arn
}
