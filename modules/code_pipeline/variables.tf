variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment (e.g., dev, prod)"
  type        = string
}

variable "region" {
  description = "Region"
  type        = string
}

variable "autoscaling_group_name" {
  description = "Autoscaling group name"
  type        = string
}

variable "alb_target_group_name" {
  description = "ALB target group name"
  type        = string
}

variable "ecr_repository_url" {
  description = "ECR repository URL"
  type        = string
}

variable "ecr_repository_name" {
  description = "ECR repository name"
  type        = string
}
