variable "amazon_linux_ami" {
  description = "The Amazon Linux AMI ID"
  type        = string
}

variable "environment" {
  description = "Environment (e.g., dev, prod)"
  type        = string
}

variable "instance_type" {
  description = "The instance type to use"
  type        = string
}

variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC"
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

variable "public_subnet_1" {
  description = "The ID of the public subnet 1"
  type        = string
}

variable "public_subnet_2" {
  description = "The ID of the public subnet 2"
  type        = string
}


variable "ec2_security_group_id" {
  description = "The ID of the EC2 security group"
  type        = string
}

variable "bastion_security_group_id" {
  description = "The ID of the bastion security group"
  type        = string
}

variable "alb_security_group_id" {
  description = "The ID of the ALB security group"
  type        = string
}

variable "certificate_arn" {
  description = "The ARN of the ALB certificate"
  type        = string
}
