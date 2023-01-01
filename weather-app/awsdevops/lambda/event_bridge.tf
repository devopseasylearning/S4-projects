resource "aws_cloudwatch_event_rule" "repo-ci" {
  name          = "captures-branch-changes"
  description   = "Captures branches created or deleted in CodeCommit"
  event_pattern = jsonencode({
    source      = [
      "aws.codecommit"
    ]
    detail-type = [
      "CodeCommit Repository State Change"
    ],
    detail      = {
      event         = [
        "referenceCreated",
        "referenceDeleted"
      ],
      referenceType = ["branch"]
    }
  })
}
resource "aws_cloudwatch_event_target" "lambda-ci" {
  target_id = "Lambda"
  rule      = aws_cloudwatch_event_rule.repo-ci.name
  arn       = aws_lambda_function.codepipeline-ci.arn
}

resource "aws_cloudwatch_event_rule" "repo-promote" {
  name          = "captures-tag-pushes"
  description   = "Captures Git tags"
  event_pattern = jsonencode({
    source      = [
      "aws.codecommit"
    ]
    detail-type = [
      "CodeCommit Repository State Change"
    ],
    detail      = {
      event         = [
        "referenceCreated"
      ],
      referenceType = ["tag"]
    }
  })
}
resource "aws_cloudwatch_event_target" "lambda-promote" {
  target_id = "Lambda"
  rule      = aws_cloudwatch_event_rule.repo-promote.name
  arn       = aws_lambda_function.codepipeline-promotion.arn
}