resource "aws_codepipeline" "codepipeline" {
  name     = "${var.project_name}-delivery-pipeline"
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    location = aws_s3_bucket.codepipeline_bucket.bucket
    type     = "S3"
  }

  stage {
    name = "Source"
    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeCommit"
      version          = "1"
      output_artifacts = ["source_output"]
      configuration    = {
        RepositoryName = var.project_name
        BranchName     = "main"
      }
    }
  }

  stage {
    name = "Delivery"
    action {
      name             = "Delivery"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version          = "1"
      configuration    = {
        ProjectName = var.codebuild_delivery_project_name
      }
    }
  }
}

resource "aws_s3_bucket" "codepipeline_bucket" {
  bucket = "${var.project_name}.linuxschoolonline.com"
  acl    = "private"
}

resource "aws_iam_role" "codepipeline_role" {
  name = "${var.project_name}-codepipeline-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codepipeline.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "codepipeline_policy" {
  name = "${var.project_name}-codepipeline_policy"
  role = aws_iam_role.codepipeline_role.id

  policy = jsonencode({
    Statement = [
      {
        Action   = [
          "codecommit:CancelUploadArchive",
          "codecommit:GetBranch",
          "codecommit:GetCommit",
          "codecommit:GetUploadArchiveStatus",
          "codecommit:UploadArchive"
        ],
        Resource = "*",
        Effect   = "Allow"
      },
      {
        Action   = [
          "s3:*"
        ],
        Resource = "*",
        Effect   = "Allow"
      },
      {
        Action   = [
          "codebuild:BatchGetBuilds",
          "codebuild:StartBuild",
          "codebuild:BatchGetBuildBatches",
          "codebuild:StartBuildBatch"
        ],
        Resource = "*",
        Effect   = "Allow"
      },
      {
        Effect   = "Allow",
        Action   = [
          "ecr:DescribeImages"
        ],
        Resource = "*"
      }
#      {
#        "Action" : ["iam:PassRole"],
#        "Resource" : "*",
#        "Effect" : "Allow"
#      }
    ],
    Version   = "2012-10-17"
  })
}