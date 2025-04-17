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
    bucket = "durianpy-terraform-state-poc"
    key    = "tf/terraform.tfstate"
    region = "ap-southeast-1"
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

output "bastion_private_key_pem" {
  value     = module.vpc.private_key_pem
  sensitive = true
}