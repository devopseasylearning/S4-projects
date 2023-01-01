resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda-${var.project_name}"
  assume_role_policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [
      {
        Action    = "sts:AssumeRole",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
        Effect    = "Allow"
      }
    ]
  })
}
resource "aws_iam_policy" "codepipeline_lambda_policy" {
  name        = "cpl_lambda-${var.project_name}"
  path        = "/"
  description = "IAM policy for the CodeBuild Lambda function"
  policy      = jsonencode({
    Version   = "2012-10-17",
    Statement = [
      {
        Action   = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "arn:aws:logs:*:*:*",
        Effect   = "Allow"
      },
      {
        Action   = [
          "codepipeline:*"
        ],
        Resource = "*",
        Effect   = "Allow"
      },
      {
        Effect = "Allow",
        Action = [
          "iam:PassRole"
        ],
        "Resource" : var.codepipeline_role_arn
      }
    ]
  })
}
resource "aws_iam_role_policy_attachment" "cp_lambda" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.codepipeline_lambda_policy.arn
}
resource "aws_lambda_permission" "allow_event_bridge" {
  statement_id  = "AllowExecutionFromCodeCommitFunction"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.codepipeline-ci.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.repo-ci.arn
}
resource "aws_lambda_permission" "allow_event_bridge-to-promotion" {
  statement_id  = "AllowExecutionFromCodeCommitPromotionFunction"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.codepipeline-promotion.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.repo-promote.arn
}