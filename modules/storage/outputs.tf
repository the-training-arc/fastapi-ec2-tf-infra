output "rds_instance_address" {
  value = aws_db_instance.rds_instance.address
}

output "rds_instance_port" {
  value = aws_db_instance.rds_instance.port
}

output "rds_instance_username" {
  value = aws_db_instance.rds_instance.username
}

output "rds_instance_password" {
  value = aws_db_instance.rds_instance.password
}