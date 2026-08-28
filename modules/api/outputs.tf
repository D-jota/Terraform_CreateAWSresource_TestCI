output "api_gw_id" {
  value = aws_api_gateway_rest_api.lims.id
}

output "api_stage_name" {
  value = aws_api_gateway_stage.lims.stage_name
}

output "vpc_link_id" {
  value = aws_api_gateway_vpc_link.lims.id
}

output "api_gw_execute_api_domain" {
  value = "${aws_api_gateway_rest_api.lims.id}.execute-api.${var.region}.amazonaws.com"
}

output "api_gw_invoke_url" {
  value = "https://${aws_api_gateway_rest_api.lims.id}.execute-api.${var.region}.amazonaws.com/${aws_api_gateway_stage.lims.stage_name}"
}
