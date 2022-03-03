resource "aws_lambda_function" "echo_function" {
  function_name = "echoFunctionNew"
  filename      = "lambda.zip"

  runtime = "nodejs14.x"
  handler = "lambda.handler"

  source_code_hash = data.archive_file.lambda_echo.output_base64sha256

  role = aws_iam_role.lambda_role2.arn
}

resource "aws_lambda_permission" "api_gw" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.echo_function.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.api_lambda_new.execution_arn}/*/*"
}