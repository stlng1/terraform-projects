# The entire section create a certiface, public zone, and validate the certificate using DNS method

# Create the certificate using a wildcard for all the domains created in orieja.com.ng
resource "aws_acm_certificate" "orieja" {
  domain_name       = "*.orieja.com.ng"
  validation_method = "DNS"
}

# calling the hosted zone
data "aws_route53_zone" "orieja" {
  name         = "orieja.com.ng"
  private_zone = false
}

# selecting validation method
resource "aws_route53_record" "orieja" {
  for_each = {
    for dvo in aws_acm_certificate.orieja.domain_validation_options : dvo.domain_name => {
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
  zone_id         = data.aws_route53_zone.orieja.zone_id
}

# validate the certificate through DNS method
resource "aws_acm_certificate_validation" "orieja" {
  certificate_arn         = aws_acm_certificate.orieja.arn
  validation_record_fqdns = [for record in aws_route53_record.orieja : record.fqdn]
}

# create records for tooling
resource "aws_route53_record" "tooling" {
  zone_id = data.aws_route53_zone.orieja.zone_id
  name    = "tooling.orieja.com.ng"
  type    = "A"

  alias {
    name                   = aws_lb.publicALB.dns_name
    zone_id                = aws_lb.publicALB.zone_id
    evaluate_target_health = true
  }
}

# create records for wordpress
resource "aws_route53_record" "wordpress" {
  zone_id = data.aws_route53_zone.orieja.zone_id
  name    = "wordpress.orieja.com.ng"
  type    = "A"

  alias {
    name                   = aws_lb.publicALB.dns_name
    zone_id                = aws_lb.publicALB.zone_id
    evaluate_target_health = true
  }
}


# #create AWS ACM certificate for your domain name
# resource "aws_route53_zone" "domain-name_zone" {
#   name = var.root_domain_name
# }
# #create an ACM Certificate
# resource "aws_acm_certificate" "domain-name_certificate" {
#   domain_name       = "*.[var.root_domain_name]"
#   validation_method = "DNS"
#   lifecycle {
#     create_before_destroy = true
#   }
# }

# #add DNS record
# resource "aws_route53_record" "domain-name_cert_dns" {
#   allow_overwrite = true
#   name            = tolist(aws_acm_certificate.domain-name_certificate.domain_validation_options)[0].resource_record_name
#   records         = [tolist(aws_acm_certificate.domain-name_certificate.domain_validation_options)[0].resource_record_value]
#   type            = tolist(aws_acm_certificate.domain-name_certificate.domain_validation_options)[0].resource_record_type
#   zone_id         = aws_route53_zone.domain-name_zone.zone_id
#   ttl             = 60
# }

# # validate the certificate
# resource "aws_acm_certificate_validation" "domain-name_cert_validate" {
#   certificate_arn         = aws_acm_certificate.domain-name_certificate.arn
#   validation_record_fqdns = [aws_route53_record.domain-name_cert_dns.fqdn]
# }