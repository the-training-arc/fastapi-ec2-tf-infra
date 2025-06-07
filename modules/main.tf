terraform {
  required_version = ">= 1.2.0"
}


module "compute" {
  source           = "./compute"
  amazon_linux_ami = var.amazon_linux_ami
  environment      = var.environment
  instance_type    = var.instance_type
  project_name     = var.project_name

  # Pass networking resources
  vpc_id = module.networking.vpc_id

  private_subnet_1 = module.networking.private_subnet_1
  private_subnet_2 = module.networking.private_subnet_2
  private_subnet_3 = module.networking.private_subnet_3
  private_subnet_4 = module.networking.private_subnet_4

  public_subnet_1 = module.networking.public_subnet_1
  public_subnet_2 = module.networking.public_subnet_2
  certificate_arn = module.dns.certificate_arn

  # Pass security group IDs
  ec2_security_group_id     = module.security.ec2_security_group_id
  bastion_security_group_id = module.security.bastion_security_group_id
  alb_security_group_id     = module.security.alb_security_group_id

  rds_instance_arn   = module.storage.rds_instance_arn
  ecr_repository_url = module.ecr.ecr_repository_url
}

module "networking" {
  source       = "./networking"
  project_name = var.project_name
  environment  = var.environment
}

module "dns" {
  source       = "./dns"
  project_name = var.project_name
  environment  = var.environment
  subdomain    = var.subdomain
  root_domain  = var.root_domain
  alb_dns_name = module.compute.alb_dns_name
  alb_zone_id  = module.compute.alb_zone_id
}

module "security" {
  source       = "./security"
  project_name = var.project_name
  environment  = var.environment

  vpc_id         = module.networking.vpc_id
  vpc_cidr_block = module.networking.vpc_cidr_block

  public_subnet_1  = module.networking.public_subnet_1
  public_subnet_2  = module.networking.public_subnet_2
  private_subnet_1 = module.networking.private_subnet_1
  private_subnet_2 = module.networking.private_subnet_2
  private_subnet_3 = module.networking.private_subnet_3
  private_subnet_4 = module.networking.private_subnet_4
}

module "storage" {
  source       = "./storage"
  project_name = var.project_name
  environment  = var.environment

  private_subnet_3 = module.networking.private_subnet_3
  private_subnet_4 = module.networking.private_subnet_4

  rds_security_group_id = module.security.rds_security_group_id
}

module "ecr" {
  source       = "./ecr"
  project_name = var.project_name
  environment  = var.environment
}

module "code_pipeline" {
  source                 = "./code_pipeline"
  project_name           = var.project_name
  environment            = var.environment
  region                 = var.region
  autoscaling_group_name = module.compute.autoscaling_group_name
  alb_target_group_name  = module.compute.alb_target_group_name
  ecr_repository_url     = module.ecr.ecr_repository_url
  ecr_repository_name    = module.ecr.ecr_repository_name
}

module "secrets" {
  source       = "./secrets"
  project_name = var.project_name
  environment  = var.environment

  database_url      = module.storage.rds_instance_address
  database_user     = module.storage.rds_instance_username
  database_password = module.storage.rds_instance_password
  database_name     = module.storage.rds_instance_name
}

resource "local_file" "private_key" {
  content         = module.compute.private_key_pem
  filename        = "${path.module}/private_key.pem"
  file_permission = "0600"
}

# resource "null_resource" "ansible" {
#   provisioner "local-exec" {
#     command = "cd ansible && ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook --inventory inventory.aws_ec2.yml site.yml"
#   }

#   triggers = {
#     always_run = timestamp()
#   }

#   depends_on = [
#     module.compute,
#     local_file.private_key
#   ]
# }
