# The entire section create a certiface, public zone, and validate the certificate using DNS method

# Create the certificate using a wildcard for all the domains created in root domain name
resource "aws_acm_certificate" "root_domain_certificate" {
  domain_name       = "*.${var.root_domain_name}"
  validation_method = "DNS"
}

# calling the hosted zone
data "aws_route53_zone" "root_domain_zone" {
  name         = "var.root_domain_name"
  private_zone = false
}

# selecting validation method
resource "aws_route53_record" "root_domain_record" {
  for_each = {
    for dvo in aws_acm_certificate.root_domain_certificate.domain_validation_options : dvo.domain_name => {
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
  zone_id         = data.aws_route53_zone.root_domain_zone.zone_id
}

# validate the certificate through DNS method
resource "aws_acm_certificate_validation" "root_domain_validation" {
  certificate_arn         = aws_acm_certificate.root_domain_certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.root_domain_record : record.fqdn]
}

# create records for sub domains - tooling and wordpress
resource "aws_route53_record" "sub_domain" {
  for_each    = local.sub_domains
  name        = each.value.name
  zone_id = data.aws_route53_zone.root_domain_zone.zone_id
  type    = "A"

  alias {
    name                   = aws_lb.publicALB.dns_name
    zone_id                = aws_lb.publicALB.zone_id
    evaluate_target_health = true
  }
}


#  create records for tooling
# resource "aws_route53_record" "tooling" {
#   zone_id = data.aws_route53_zone.oyindamola.zone_id
#   name    = "tooling.oyindamola.gq"
#   type    = "A"

#   alias {
#     name                   = aws_lb.ext-alb.dns_name
#     zone_id                = aws_lb.ext-alb.zone_id
#     evaluate_target_health = true
#   }
# }


# # create records for wordpress
# resource "aws_route53_record" "wordpress" {
#   zone_id = data.aws_route53_zone.oyindamola.zone_id
#   name    = "wordpress.oyindamola.gq"
#   type    = "A"

#   alias {
#     name                   = aws_lb.ext-alb.dns_name
#     zone_id                = aws_lb.ext-alb.zone_id
#     evaluate_target_health = true
#   }
# }
