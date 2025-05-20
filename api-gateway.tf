/**********************************************************
  # Add the API Gatewy
**********************************************************/

resource "aws_api_gateway_rest_api" "customer_api" {
  name        = "customer_api"
  description = "API Gateway for customer service"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

/**********************************************************
*** # Add /demo resource to the API Gateway
**********************************************************/
resource "aws_api_gateway_resource" "customer_api_create_resource" {
  rest_api_id = aws_api_gateway_rest_api.customer_api.id
  parent_id   = aws_api_gateway_rest_api.customer_api.root_resource_id
  path_part   = "create"
}


/**********************************************************
*** # Add first gateway METHOD - aws_api_gateway_method
**********************************************************/
resource "aws_api_gateway_method" "customer_api_create_method_post" {
  rest_api_id   = aws_api_gateway_rest_api.customer_api.id
  resource_id   = aws_api_gateway_resource.customer_api_create_resource.id
  http_method   = "POST"
  authorization = "NONE"
}

/**********************************************************
*** # Add lambda integration
**********************************************************/
resource "aws_api_gateway_integration" "aws_customer_api_integration" {
  rest_api_id             = aws_api_gateway_rest_api.customer_api.id
  resource_id             = aws_api_gateway_resource.customer_api_create_resource.id
  http_method             = aws_api_gateway_method.customer_api_create_method_post.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = aws_lambda_function.service_customer_api_function.invoke_arn
}

resource "aws_api_gateway_method_response" "customer_api_create_method_response" {
  rest_api_id = aws_api_gateway_rest_api.customer_api.id
  resource_id = aws_api_gateway_resource.customer_api_create_resource.id
  http_method = aws_api_gateway_method.customer_api_create_method_post.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin"  = true
  }
}

resource "aws_api_gateway_integration_response" "customer_api_create_integration_response" {
    rest_api_id = aws_api_gateway_rest_api.customer_api.id
    resource_id = aws_api_gateway_resource.customer_api_create_resource.id
    http_method = aws_api_gateway_method.customer_api_create_method_post.http_method
    status_code = aws_api_gateway_method_response.customer_api_create_method_response.status_code
    response_parameters = {
      "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
      "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
      "method.response.header.Access-Control-Allow-Origin"  = "'*'"
    }


  depends_on = [
    aws_api_gateway_method.customer_api_create_method_post,
    aws_api_gateway_integration.aws_customer_api_integration
  ]
}


/**********************************************************
*** # Add lambda integration
**********************************************************/
resource "aws_api_gateway_deployment" "customer_api_deployment" {
  depends_on = [
    aws_api_gateway_integration.aws_customer_api_integration
  ]

  rest_api_id = aws_api_gateway_rest_api.customer_api.id
  stage_name  = "development"
}