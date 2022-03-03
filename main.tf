provider "aws" {
  region = var.aws_region
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


