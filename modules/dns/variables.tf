variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment (e.g., dev, prod)"
  type        = string
}

variable "subdomain" {
  type        = string
  description = "Subdomain for the application"
}

variable "root_domain" {
  type        = string
  description = "Root domain name"
}

variable "alb_dns_name" {
  type        = string
  description = "DNS name of the ALB"
}

variable "alb_zone_id" {
  type        = string
  description = "Zone ID of the ALB"
}
