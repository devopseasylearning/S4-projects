data "aws_caller_identity" "current" {}
locals {
  project_name = var.project_name
}
resource "aws_codebuild_project" "codebuild_delivery" {
  name          = "${var.project_name}-delivery"
  build_timeout = "30"
  service_role  = aws_iam_role.codebuild_role.arn
  badge_enabled = true
  artifacts {
    type = "NO_ARTIFACTS"
  }
  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:5.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true
    environment_variable {
      name  = "AWS_DEFAULT_REGION"
      value = var.region
    }
    environment_variable {
      name  = "AWS_ACCOUNT_ID"
      value = data.aws_caller_identity.current.account_id
    }
    environment_variable {
      name  = "IMAGE_REPO_NAME"
      value = var.IMAGE_REPO_NAME
    }
    environment_variable {
      name  = "EKS_CLUSTER_NAME"
      value = var.EKS_CLUSTER_NAME
    }
    environment_variable {
      name  = "DB_PASSWORD"
      value = var.DB_PASSWORD
    }
    environment_variable {
      name  = "API_KEY"
      value = var.API_KEY
    }
  }
  source {
    type      = "CODECOMMIT"
    location  = "https://git-codecommit.${var.region}.amazonaws.com/v1/repos/${var.project_name}"
    buildspec = "delivery.yml"
  }
}

resource "aws_codebuild_project" "codebuild_CI" {
  name          = "${var.project_name}-CI"
  build_timeout = "30"
  service_role  = aws_iam_role.codebuild_role.arn
  badge_enabled = true
  artifacts {
    type = "NO_ARTIFACTS"
  }
  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:5.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true
    environment_variable {
      name  = "AWS_DEFAULT_REGION"
      value = var.region
    }
    environment_variable {
      name  = "AWS_ACCOUNT_ID"
      value = data.aws_caller_identity.current.account_id
    }
    environment_variable {
      name  = "IMAGE_REPO_NAME"
      value = var.IMAGE_REPO_NAME
    }
  }
  source {
    type      = "CODECOMMIT"
    location  = "https://git-codecommit.${var.region}.amazonaws.com/v1/repos/${var.project_name}"
    buildspec = "ci.yml"
  }
}
resource "aws_codebuild_project" "codebuild_deploy" {
  name          = "${var.project_name}-deploy"
  build_timeout = "30"
  service_role  = aws_iam_role.codebuild_role.arn
  badge_enabled = true
  artifacts {
    type = "NO_ARTIFACTS"
  }
  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:5.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true
    environment_variable {
      name  = "AWS_DEFAULT_REGION"
      value = var.region
    }
    environment_variable {
      name  = "AWS_ACCOUNT_ID"
      value = data.aws_caller_identity.current.account_id
    }
    environment_variable {
      name  = "IMAGE_REPO_NAME"
      value = var.IMAGE_REPO_NAME
    }
    environment_variable {
      name  = "EKS_CLUSTER_NAME"
      value = var.EKS_CLUSTER_NAME
    }
    environment_variable {
      name  = "DB_PASSWORD"
      value = var.DB_PASSWORD
    }
    environment_variable {
      name  = "API_KEY"
      value = var.API_KEY
    }
    environment_variable {
      name  = "CI_COMMIT_TAG"
      value = ""
    }
  }
  source {
    type      = "CODECOMMIT"
    location  = "https://git-codecommit.${var.region}.amazonaws.com/v1/repos/${var.project_name}"
    buildspec = "deployment.yml"
  }
}

resource "aws_codebuild_project" "codebuild_promotion" {
  name          = "${var.project_name}-promotion"
  build_timeout = "30"
  service_role  = aws_iam_role.codebuild_role.arn
  badge_enabled = true
  artifacts {
    type = "NO_ARTIFACTS"
  }
  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:5.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true
    environment_variable {
      name  = "AWS_DEFAULT_REGION"
      value = var.region
    }
    environment_variable {
      name  = "AWS_ACCOUNT_ID"
      value = data.aws_caller_identity.current.account_id
    }
    environment_variable {
      name  = "IMAGE_REPO_NAME"
      value = var.IMAGE_REPO_NAME
    }
  }
  source {
    type      = "CODECOMMIT"
    location  = "https://git-codecommit.${var.region}.amazonaws.com/v1/repos/${var.project_name}"
    buildspec = "promotion.yml"
  }
}