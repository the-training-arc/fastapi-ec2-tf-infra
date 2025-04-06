terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.0"
    }
  }

  backend "s3" {
    bucket         = "pants-poc-terraform-state"
    key            = "lambda/terraform.tfstate"
    region         = "ap-southeast-1"
    dynamodb_table = "pants-poc-terraform-lock"
  }
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Environment = var.environment
      Service     = "${local.resource_prefix}"
      Terraform   = "true"
    }
  }
}

module "vpc" {
  source = "./modules"
}

locals {
  resource_prefix = "${var.project_name}-${var.environment}"
}