resource "aws_api_gateway_vpc_link" "lims" {
  name        = "${var.project}-vpc-link"
  target_arns = [var.nlb_arn]
}

resource "aws_api_gateway_rest_api" "lims" {
  name        = "${var.project}-api"
  description = "LIMS backend API proxied to the internal NLB"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_authorizer" "cognito" {
  count           = var.enable_authorizer ? 1 : 0
  name            = "${var.project}-cognito-authorizer"
  rest_api_id     = aws_api_gateway_rest_api.lims.id
  type            = "COGNITO_USER_POOLS"
  provider_arns   = [var.user_pool_arn]
  identity_source = "method.request.header.Authorization"
}

resource "aws_api_gateway_resource" "api" {
  rest_api_id = aws_api_gateway_rest_api.lims.id
  parent_id   = aws_api_gateway_rest_api.lims.root_resource_id
  path_part   = "api"
}

resource "aws_api_gateway_resource" "proxy" {
  rest_api_id = aws_api_gateway_rest_api.lims.id
  parent_id   = aws_api_gateway_resource.api.id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "proxy" {
  rest_api_id   = aws_api_gateway_rest_api.lims.id
  resource_id   = aws_api_gateway_resource.proxy.id
  http_method   = "ANY"
  authorization = var.enable_authorizer ? "COGNITO_USER_POOLS" : "NONE"
  authorizer_id = var.enable_authorizer ? aws_api_gateway_authorizer.cognito[0].id : null

  request_parameters = {
    "method.request.path.proxy" = true
  }
}

resource "aws_api_gateway_integration" "proxy" {
  rest_api_id     = aws_api_gateway_rest_api.lims.id
  resource_id     = aws_api_gateway_resource.proxy.id
  http_method     = "ANY"
  type            = "HTTP_PROXY"
  uri             = "http://${var.nlb_dns_name}:${var.app_port}/{proxy}"
  connection_type = "VPC_LINK"
  connection_id   = aws_api_gateway_vpc_link.lims.id

  request_parameters = {
    "integration.request.path.proxy" = "method.request.path.proxy"
  }
}

resource "aws_api_gateway_deployment" "lims" {
  rest_api_id = aws_api_gateway_rest_api.lims.id
  depends_on  = [aws_api_gateway_method.proxy, aws_api_gateway_integration.proxy]

  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_rest_api.lims.id,
      aws_api_gateway_method.proxy.id,
      aws_api_gateway_integration.proxy.id,
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "lims" {
  deployment_id = aws_api_gateway_deployment.lims.id
  rest_api_id   = aws_api_gateway_rest_api.lims.id
  stage_name    = var.stage_name
}

resource "aws_api_gateway_method_settings" "lims" {
  rest_api_id = aws_api_gateway_rest_api.lims.id
  stage_name  = aws_api_gateway_stage.lims.stage_name
  method_path = "*/*"

  settings {
    metrics_enabled        = true
    logging_level          = "INFO"
    throttling_burst_limit = 100
    throttling_rate_limit  = 50
  }
}
