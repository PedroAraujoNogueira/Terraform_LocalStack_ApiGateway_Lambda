resource "aws_iam_role" "lambda_role2" {
  name = "serverless_lambda_new5"

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