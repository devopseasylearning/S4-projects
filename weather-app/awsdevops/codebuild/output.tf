output "codebuild_delivery_project_arn" {
  value = aws_codebuild_project.codebuild_delivery.arn
}
output "codebuild_delivery_project_name" {
  value = aws_codebuild_project.codebuild_delivery.name
}
output "codebuild_ci_project_name" {
  value = aws_codebuild_project.codebuild_CI.name
}
output "codebuild_promotion_project_name" {
  value = aws_codebuild_project.codebuild_promotion.name
}
output "codebuild_deployment_project_arn" {
  value = aws_codebuild_project.codebuild_deploy.arn
}
output "codebuild_ci_project_arn" {
  value = aws_codebuild_project.codebuild_CI.arn
}
output "codebuild_promotion_project_arn" {
  value = aws_codebuild_project.codebuild_promotion.arn
}
output "codebuild_role_arn" {
  value = aws_iam_role.codebuild_role.arn
}