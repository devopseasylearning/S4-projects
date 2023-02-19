resource "aws_iam_role" "codebuild_role" {
  name               = "${var.project_name}_codebuild_role"
  assume_role_policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        },
        Action    = [
          "sts:AssumeRole"
        ]
      },
      {
        Effect    = "Allow",
        Principal = {
          Service = "codebuild.amazonaws.com"
        },
        Action    = "sts:AssumeRole"
      }
    ]
  })
}
resource "aws_iam_role_policy" "codebuild_policy" {
  role   = aws_iam_role.codebuild_role.name
  policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Resource = [
          "arn:aws:codecommit:${var.region}:${data.aws_caller_identity.current.account_id}:${var.project_name}"
        ]
        Action   = [
          "codecommit:GitPull"
        ]
      },
      {
        Action     = [
          "ecr:BatchCheckLayerAvailability",
          "ecr:CompleteLayerUpload",
          "ecr:GetAuthorizationToken",
          "ecr:InitiateLayerUpload",
          "ecr:PutImage",
          "ecr:UploadLayerPart",
          "ecr:CreateRepository",
          "ecr:DescribeRepositories",
          "ecr:BatchGetImage",
          "ecr:GetDownloadUrlForLayer",
          "eks:DescribeNodegroup",
          "eks:DescribeUpdate",
          "eks:DescribeCluster",
          "s3:*"
        ],
        "Resource" = "*",
        "Effect"   = "Allow"
      },
      {
        "Action"   = [
          "ssm:GetParameters"
        ],
        "Resource" = [
          "arn:aws:ssm:${var.region}:${data.aws_caller_identity.current.account_id}:parameter/*"
        ],
        "Effect"   = "Allow"
      }
    ]
  })
}
resource "aws_iam_role_policy" "codebuild_log_policy" {
  role   = aws_iam_role.codebuild_role.name
  policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Resource = [
          "arn:aws:logs:${var.region}:${data.aws_caller_identity.current.account_id}:log-group:/aws/codebuild/*"
        ],
        Action   = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
      }
    ]
  })
}