resource "aws_ssm_parameter" "DB_PASSWORD" {
  name  = "/${var.project_name}/DB_PASSWORD"
  type  = "SecureString"
  value = var.DB_PASSWORD
}
resource "aws_ssm_parameter" "API_KEY" {
  name  = "/${var.project_name}/API_KEY"
  type  = "SecureString"
  value = var.API_KEY
}