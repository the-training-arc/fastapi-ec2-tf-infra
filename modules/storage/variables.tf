variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment (e.g., dev, prod)"
  type        = string
}

variable "private_subnet_3" {
  description = "The ID of the private subnet 3"
  type        = string
}

variable "private_subnet_4" {
  description = "The ID of the private subnet 4"
  type        = string
}

variable "rds_security_group_id" {
  description = "The ID of the RDS security group"
  type        = string
}