# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "region" {
  type        = string
  description = "AWS region for all resources."

  default = "ap-southeast-1"
}

variable "environment" {
  type        = string
  description = "Environment for all resources."

  default = "dev"
}

variable "project_name" {
  type        = string
  description = "Name of the example project."

  default = "tf-three-tier"
}

variable "amazon_linux_ami" {
  type        = string
  description = "Amazon Linux AMI ID"

  default = "ami-065a492fef70f84b1"
}

variable "domain_name" {
  type        = string
  description = "Domain name for the application."

  default = "durianpy.org"
}

variable "instance_type" {
  type        = string
  description = "Instance type for the application."

  default = "t2.micro"
}
