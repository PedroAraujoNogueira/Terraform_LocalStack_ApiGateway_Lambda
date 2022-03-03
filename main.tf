provider "aws" {
  region = "us-east-1"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    apigateway     = "http://localhost:4566"
    lambda         = "http://localhost:4566"
  }
}

data "archive_file" "lambda_echo" {
  type = "zip"

  source_dir  = "lambda"
  output_path = "lambda.zip"
}

resource "aws_iam_role" "lambda_role2" {
  name = "serverless_lambda_new4"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Sid    = ""
      Principal = {
        Service = "lambda.amazonaws.com"
      }  
    }]
  })
}

resource "aws_lambda_function" "echo_function" {
  function_name = "echoFunctionNew"
  filename      = "lambda.zip"

  runtime = "nodejs14.x"
  handler = "lambda.handler"

  source_code_hash = data.archive_file.lambda_echo.output_base64sha256

  role = aws_iam_role.lambda_role2.arn
}

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

resource "aws_api_gateway_stage" "example" {
  deployment_id = aws_api_gateway_deployment.lambda_deployment_new.id
  rest_api_id   = aws_api_gateway_rest_api.api_lambda_new.id
  stage_name    = "apiLambdaStageNew"
}

resource "aws_lambda_permission" "api_gw" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.echo_function.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.api_lambda_new.execution_arn}/*/*"
}

output "url_api_gateway" {
  value = aws_api_gateway_deployment.lambda_deployment_new.invoke_url
}

output "url_api_gateway_stage" {
  value = aws_api_gateway_stage.example.invoke_url
}

output "url_api_gateway_path" {
  value = aws_api_gateway_resource.lambda_resource_new.path
}