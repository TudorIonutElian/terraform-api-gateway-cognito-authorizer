/*****************************************************
 * Data source to get the hosted zone ID
 ****************************************************/
data "aws_route53_zone" "learndevtech" {
  name         = "learndevtech.com"
  private_zone = false
}

/*****************************************************
 * Create a certificate for the domain
 ****************************************************/
resource "aws_acm_certificate" "learndevtech_certificate" {
  domain_name       = "api.learndevtech.com"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

/*****************************************************
 * Create a record for the API Gateway
 ****************************************************/
resource "aws_route53_record" "api_domain_record" {
  name = "api"
  type = "CNAME"
  ttl  = "300"

  records = ["${aws_api_gateway_rest_api.customer_api.id}.execute-api.eu-central-1.amazonaws.com"]
  zone_id = data.aws_route53_zone.learndevtech.zone_id
}

resource "aws_api_gateway_base_path_mapping" "customer_api_mapping" {
    api_id      = aws_api_gateway_rest_api.customer_api.id
    stage_name  = aws_api_gateway_stage.customer_api_stage.stage_name
    domain_name = aws_api_gateway_domain_name.learndevtech_domain.domain_name
    base_path   = "customer"
}