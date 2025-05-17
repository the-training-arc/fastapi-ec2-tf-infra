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
    bucket = "durianpy-infra-terraform-state"
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
      Project     = var.project_name
      Terraform   = "true"
    }
  }
}

locals {
  resource_prefix = "${var.project_name}-${var.environment}"
}

module "infra" {
  source       = "./modules"
  project_name = var.project_name
  environment  = var.environment
  region       = var.region
}

output "bastion_private_key_pem" {
  value     = module.infra.bastion_private_key_pem
  sensitive = true
}

output "private_key_pem" {
  value     = module.infra.private_key_pem
  sensitive = true
}
