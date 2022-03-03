output "stage" {
  value = aws_api_gateway_stage.lambda_stage_new.invoke_url
}

output "url" {
  value = "http://localhost:4566/restapis/${aws_api_gateway_rest_api.api_lambda_new.id}/${aws_api_gateway_stage.lambda_stage_new.stage_name}/_user_request_${aws_api_gateway_resource.lambda_resource_new.path}"
}
