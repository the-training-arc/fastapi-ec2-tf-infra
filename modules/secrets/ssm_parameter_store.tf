resource "aws_ssm_parameter" "db_url" {
  name        = "/${var.project_name}/${var.environment}/database/url"
  description = "The parameter description"
  type        = "SecureString"
  value       = var.database_url
}

resource "aws_ssm_parameter" "db_user" {
  name        = "/${var.project_name}/${var.environment}/database/user"
  description = "The parameter description"
  type        = "SecureString"
  value       = var.database_user
}

resource "aws_ssm_parameter" "db_password" {
  name        = "/${var.project_name}/${var.environment}/database/password"
  description = "The parameter description"
  type        = "SecureString"
  value       = var.database_password
}
