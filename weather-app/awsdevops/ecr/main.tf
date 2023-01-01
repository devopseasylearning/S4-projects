resource "aws_ecr_repository" "auth" {
  name = "weatherapp-auth"
}
resource "aws_ecr_repository" "ui" {
  name = "weatherapp-ui"
}
resource "aws_ecr_repository" "weather" {
  name = "weatherapp-weather"
}