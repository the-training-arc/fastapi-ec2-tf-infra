output "bastion_private_key_pem" {
  value     = module.compute.bastion_private_key_pem
  sensitive = true
}

output "private_key_pem" {
  value     = module.compute.private_key_pem
  sensitive = true
}
