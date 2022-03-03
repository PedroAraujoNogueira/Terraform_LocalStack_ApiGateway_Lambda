resource "aws_api_gateway_rest_api" "api_lambda_new" {
  name          = "apiLambdaNew"
}

resource "aws_api_gateway_resource" "lambda_resource_new" {
  parent_id   = aws_api_gateway_rest_api.api_lambda_new.root_resource_id
  path_part   = "echoserver"
  rest_api_id = aws_api_gateway_rest_api.api_lambda_new.id
}

resource "aws_api_gateway_method" "lambda_method_new" {
  authorization = "NONE"
  http_method   = "POST"
  resource_id   = aws_api_gateway_resource.lambda_resource_new.id
  rest_api_id   = aws_api_gateway_rest_api.api_lambda_new.id
}

resource "aws_api_gateway_integration" "lambda_integration_new" {
  rest_api_id             = aws_api_gateway_rest_api.api_lambda_new.id
  resource_id             = aws_api_gateway_resource.lambda_resource_new.id
  http_method             = aws_api_gateway_method.lambda_method_new.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.echo_function.invoke_arn
}

resource "aws_api_gateway_deployment" "lambda_deployment_new" {
  rest_api_id = aws_api_gateway_rest_api.api_lambda_new.id

  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_resource.lambda_resource_new.id,
      aws_api_gateway_method.lambda_method_new.id,
      aws_api_gateway_integration.lambda_integration_new.id,
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "lambda_stage_new" {
  deployment_id = aws_api_gateway_deployment.lambda_deployment_new.id
  rest_api_id   = aws_api_gateway_rest_api.api_lambda_new.id
  stage_name    = "apiLambdaStageNew"
}