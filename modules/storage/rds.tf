resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "${local.resource_prefix}-rds-subnet-group"
  subnet_ids = [var.private_subnet_3, var.private_subnet_4]

  tags = {
    Name = "${local.resource_prefix}-rds-subnet-group"
  }
}

resource "aws_db_instance" "rds_instance" {
  db_name    = "treeTier${var.environment}treeTierRDS"
  identifier = "${local.resource_prefix}-rds"

  allocated_storage = 5
  engine            = "mysql"
  engine_version    = "8.0.40"
  instance_class    = "db.t4g.micro"

  username = "admin"
  password = "RUimA5XVjrFhYHFZ99tbh6D3TEypsgzi"

  skip_final_snapshot = true

  multi_az = false

  vpc_security_group_ids = [var.rds_security_group_id]

  availability_zone = "ap-southeast-1a"

  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name

  tags = {
    Name = "${local.resource_prefix}-rds"
  }

  depends_on = [var.rds_security_group_id]
}
