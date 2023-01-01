output "codepipeline_role_arn" {
  value = aws_iam_role.codepipeline_role.arn
}
output "codepipeline_s3_bucket" {
  value = aws_s3_bucket.codepipeline_bucket.bucket
}