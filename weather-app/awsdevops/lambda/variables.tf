variable "project_name" {
  type = string
}
variable "codepipeline_role_arn" {
  type = string
}
variable "codepipeline_s3" {
  type = string
}
variable "codebuild-ci-project" {
  type = string
}
variable "codebuild-promotion-project" {
  type = string
}
variable "repo_url" {
  type = string
}