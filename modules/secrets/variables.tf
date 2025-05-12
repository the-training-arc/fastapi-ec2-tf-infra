variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment (e.g., dev, prod)"
  type        = string
}

variable "database_url" {
  description = "The URL of the database"
  type        = string
}

variable "database_user" {
  description = "The user of the database"
  type        = string
}

variable "database_password" {
  description = "The password of the database"
  type        = string
}


