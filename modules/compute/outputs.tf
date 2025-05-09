output "bastion_private_key_pem" {
  value     = tls_private_key.ssh_key.private_key_pem
  sensitive = true
}

output "alb_dns_name" {
  value = aws_lb.main_alb.dns_name
}

output "alb_zone_id" {
  value = aws_lb.main_alb.zone_id
}

