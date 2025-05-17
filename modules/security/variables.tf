variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment (e.g., dev, prod)"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  type        = string
}

variable "public_subnet_1" {
  description = "The ID of the public subnet 1"
  type        = string
}

variable "public_subnet_2" {
  description = "The ID of the public subnet 2"
  type        = string
}

variable "private_subnet_1" {
  description = "The ID of the private subnet 1"
  type        = string
}

variable "private_subnet_2" {
  description = "The ID of the private subnet 2"
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
