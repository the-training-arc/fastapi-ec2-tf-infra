# ================================
# EC2
# ================================
resource "aws_security_group" "ec2_sg" {
  name_prefix = "ec2_sg_"

  vpc_id = var.vpc_id
}

# Allow SSH access from Bastion Host
resource "aws_vpc_security_group_ingress_rule" "ec2_ingress_ssh_bastion" {
  security_group_id            = aws_security_group.ec2_sg.id
  ip_protocol                  = "tcp"
  from_port                    = 22
  to_port                      = 22
  referenced_security_group_id = aws_security_group.bastion_sg.id
  description                  = "Allow SSH inbound traffic from Bastion Host"
}

# Allow HTTP access from ALB
resource "aws_vpc_security_group_ingress_rule" "ec2_ingress_http_alb" {
  security_group_id            = aws_security_group.ec2_sg.id
  ip_protocol                  = "tcp"
  from_port                    = 80
  to_port                      = 80
  referenced_security_group_id = aws_security_group.lb_sg.id
  description                  = "Allow HTTP traffic from ALB only"
}

#trivy:ignore:AVD-AWS-0104
resource "aws_vpc_security_group_egress_rule" "ec2_egress_all" {
  security_group_id = aws_security_group.ec2_sg.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
  description       = "Allow all outbound traffic"
}

# ================================
# Bastion Host
# ================================
resource "aws_security_group" "bastion_sg" {
  name_prefix = "bastion_sg_"

  vpc_id = var.vpc_id
}

# Allow SSH access from your IP

#trivy:ignore:AVD-AWS-0107
resource "aws_vpc_security_group_ingress_rule" "bastion_ingress" {
  security_group_id = aws_security_group.bastion_sg.id
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_ipv4         = "0.0.0.0/0"
  description       = "Allow SSH access from specific IP only"
} # TODO: replace with our SSM Session Manager access

#trivy:ignore:AVD-AWS-0104
resource "aws_vpc_security_group_egress_rule" "bastion_egress_ssh" {
  security_group_id = aws_security_group.bastion_sg.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
  description       = "Allow all outbound traffic"
}

# ================================
# RDS
# ================================
resource "aws_security_group" "rds_sg" {
  name_prefix = "rds_sg_"

  vpc_id = var.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "rds_ingress" {
  security_group_id            = aws_security_group.rds_sg.id
  ip_protocol                  = "tcp"
  from_port                    = 5432
  to_port                      = 5432
  referenced_security_group_id = aws_security_group.ec2_sg.id
  description                  = "Allow PostgreSQL access from EC2 instances only"
}

resource "aws_vpc_security_group_egress_rule" "rds_egress" {
  security_group_id = aws_security_group.rds_sg.id
  ip_protocol       = "-1"
  cidr_ipv4         = var.vpc_cidr_block
  description       = "Allow all outbound traffic within VPC only"
}

# ================================
# LB
# ================================
resource "aws_security_group" "lb_sg" {
  name_prefix = "lb_sg_"

  vpc_id = var.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "lb_ingress" {
  security_group_id = aws_security_group.lb_sg.id
  ip_protocol       = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_ipv4         = "0.0.0.0/0"
  description       = "Allow HTTP inbound traffic"
}

resource "aws_vpc_security_group_ingress_rule" "lb_ingress_https" {
  security_group_id = aws_security_group.lb_sg.id
  ip_protocol       = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_ipv4         = "0.0.0.0/0"
  description       = "Allow HTTPS inbound traffic"
}

resource "aws_vpc_security_group_egress_rule" "lb_egress" {
  security_group_id            = aws_security_group.lb_sg.id
  ip_protocol                  = "tcp"
  from_port                    = 80
  to_port                      = 80
  referenced_security_group_id = aws_security_group.ec2_sg.id
  description                  = "Allow traffic to EC2 instances only"
}
