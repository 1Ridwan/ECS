resource "aws_acm_certificate" "main_certificate" {
  domain_name       = "ridwanprojects.com"
  validation_method = "DNS"

  tags = {
    Environment = "test"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "cert_validate" {
  certificate_arn         = aws_acm_certificate.main_certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.validate : record.fqdn]
}

resource "aws_route53_record" "validate" {
  for_each = {
    for dvo in aws_acm_certificate.main_certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.validate.zone_id
}

data "aws_route53_zone" "validate" {
  name         = "ridwanprojects.com."
}