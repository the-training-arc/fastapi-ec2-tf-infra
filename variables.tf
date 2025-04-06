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