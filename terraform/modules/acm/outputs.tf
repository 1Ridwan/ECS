output "certificate_dvos" {
    value = aws_acm_certificate.main_certificate.domain_validation_options
}

output "certificate_arn" {
    value = aws_acm_certificate.main_certificate.arn
}
