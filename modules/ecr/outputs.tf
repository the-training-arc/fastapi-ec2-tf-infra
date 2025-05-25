output "ecr_repository_name" {
  description = "The name of the ECR repository"
  value       = aws_ecr_repository.fastapi_app.name
}

output "ecr_repository_arn" {
  description = "The ARN of the ECR repository"
  value       = aws_ecr_repository.fastapi_app.arn
}

output "ecr_repository_url" {
  description = "The URL of the ECR repository"
  value       = aws_ecr_repository.fastapi_app.repository_url
}