output "bastion_private_key_pem" {
  value     = module.compute.bastion_private_key_pem
  sensitive = true
}