output "bastion_private_key_pem" {
  value     = tls_private_key.ssh_key.private_key_pem
  sensitive = true
}

output "alb_dns_name" {
  value = aws_lb.main.dns_name
}

output "alb_zone_id" {
  value = aws_lb.main.zone_id
}

output "autoscaling_group_name" {
  value = aws_autoscaling_group.web_asg.name
}

output "alb_target_group_name" {
  value = aws_lb_target_group.web_tg.name
}
