resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "${local.resource_prefix}-rds-subnet-group"
  subnet_ids = [var.private_subnet_3, var.private_subnet_4]

  tags = {
    Name = "${local.resource_prefix}-rds-subnet-group"
  }
}

resource "random_password" "rds_password" {
  length           = 32
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "aws_db_instance" "rds_instance" {
  db_name    = "treeTier${var.environment}treeTierRDS"
  identifier = "${local.resource_prefix}-rds"

  allocated_storage = 5
  storage_type      = "gp2"
  storage_encrypted = true

  engine         = "postgres"
  engine_version = "16.6"
  instance_class = "db.t4g.micro"

  username = "dbadmin"
  password = random_password.rds_password.result

  multi_az            = false
  publicly_accessible = false
  skip_final_snapshot = false
  deletion_protection = false

  backup_retention_period = 7
  backup_window           = "03:00-04:00"
  maintenance_window      = "Mon:04:00-Mon:05:00"


  vpc_security_group_ids = [var.rds_security_group_id]
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name

  depends_on = [var.rds_security_group_id]
}
