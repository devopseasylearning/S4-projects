resource "aws_lambda_function" "codepipeline-ci" {
  filename         = "${path.module}/ci-lambda.zip"
  source_code_hash = filebase64sha256("${path.module}/ci-lambda.zip")
  function_name    = "${var.project_name}-CodePipeline-CI"
  role             = aws_iam_role.iam_for_lambda.arn
  handler          = "ci-lambda.lambda_handler"
  runtime          = "python3.8"
  timeout          = 300
  environment {
    variables = {
      CODEPIPELINE_ROLE_ARN  = var.codepipeline_role_arn
      CODEPIPELINE_S3_BUCKET = var.codepipeline_s3
      CODEBUILD_CI_PROJECT   = var.codebuild-ci-project
    }
  }
}
resource "aws_lambda_function" "codepipeline-promotion" {
  filename         = "${path.module}/promotion-lambda.zip"
  source_code_hash = filebase64sha256("${path.module}/promotion-lambda.zip")
  function_name    = "${var.project_name}-CodePipeline-promote"
  role             = aws_iam_role.iam_for_lambda.arn
  handler          = "promotion-lambda.lambda_handler"
  runtime          = "python3.8"
  timeout          = 300
  environment {
    variables = {
      CODEPIPELINE_ROLE_ARN       = var.codepipeline_role_arn
      CODEPIPELINE_S3_BUCKET      = var.codepipeline_s3
      CODEBUILD_PROMOTION_PROJECT = var.codebuild-promotion-project
      REPO_NAME                   = var.project_name
      REPO_URL                    = var.repo_url
    }
  }
}