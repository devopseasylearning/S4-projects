terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.70.0"
    }
  }

  required_version = ">= 1.1.2"
  backend "s3" {
    bucket = "state.kubernetes.linuxschoolonline.com"
    key    = "awsdevops.tfstate"
    region = "eu-west-2"
  }
}
provider "aws" {
  region = "eu-west-1"
}
locals {
  project_name = "weatherapp"
  repo_name = "790250078024.dkr.ecr.eu-west-1.amazonaws.com"
}
module "ecr" {
  source = "./ecr"
}
module codebuild {
  source           = "./codebuild"
  project_name     = local.project_name
  region           = "eu-west-1"
  DB_PASSWORD      = var.DB_PASSWORD
  API_KEY          = var.API_KEY
  IMAGE_REPO_NAME  = local.repo_name
  EKS_CLUSTER_NAME = "awsdevops"
}
output "codebuild_role_arn" {
  value = module.codebuild.codebuild_role_arn
}
module "lambda" {
  source = "./lambda"
  project_name = local.project_name
  codepipeline_role_arn = module.codepipeline.codepipeline_role_arn
  codepipeline_s3 = module.codepipeline.codepipeline_s3_bucket
  codebuild-ci-project = module.codebuild.codebuild_ci_project_name
  codebuild-promotion-project = module.codebuild.codebuild_promotion_project_name
  repo_url = local.repo_name
}
module "codepipeline" {
  source                           = "./codepipeline"
  project_name                     = local.project_name
  codebuild_delivery_project_arn   = module.codebuild.codebuild_delivery_project_arn
  codebuild_role_arn               = module.codebuild.codebuild_role_arn
  codebuild_ci_project_arn         = module.codebuild.codebuild_ci_project_arn
  codebuild_delivery_project_name  = module.codebuild.codebuild_delivery_project_name
  codebuild_deployment_project_arn = ""
  codebuild_promotion_project_arn  = ""
}