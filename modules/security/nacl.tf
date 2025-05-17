/* -------------------------------------------------------------------------- */
/*                               Database Layer                               */
/* -------------------------------------------------------------------------- */
resource "aws_network_acl" "db_layer" {
  vpc_id = var.vpc_id

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = var.vpc_cidr_block
    from_port  = 5432
    to_port    = 5432
  }

  egress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = var.vpc_cidr_block
    from_port  = 5432
    to_port    = 5432
  }

  # Allow inbound ephemeral ports
  ingress {
    protocol   = "tcp"
    rule_no    = 900
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }

  # Allow outbound ephemeral ports
  egress {
    protocol   = "tcp"
    rule_no    = 900
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }

  tags = {
    Name = "db-layer-nacl"
  }
}

resource "aws_network_acl_association" "db_layer_private_subnet_3" {
  network_acl_id = aws_network_acl.db_layer.id
  subnet_id      = var.private_subnet_3
}

resource "aws_network_acl_association" "db_layer_private_subnet_4" {
  network_acl_id = aws_network_acl.db_layer.id
  subnet_id      = var.private_subnet_4
}


/* -------------------------------------------------------------------------- */
/*                              Application Layer                             */
/* -------------------------------------------------------------------------- */

resource "aws_network_acl" "application_layer" {
  vpc_id = var.vpc_id

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0" # Allow HTTP from anywhere
    from_port  = 80
    to_port    = 80
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0" # Allow HTTPS from anywhere
    from_port  = 443
    to_port    = 443
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 300
    action     = "allow"
    cidr_block = var.vpc_cidr_block # Keep SSH restricted to VPC
    from_port  = 22
    to_port    = 22
  }

  # Allow inbound ephemeral ports for return traffic
  ingress {
    protocol   = "tcp"
    rule_no    = 900
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }

  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0" # Allow HTTP responses to anywhere
    from_port  = 80
    to_port    = 80
  }

  egress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0" # Allow HTTPS responses to anywhere
    from_port  = 443
    to_port    = 443
  }

  egress {
    protocol   = "tcp"
    rule_no    = 300
    action     = "allow"
    cidr_block = var.vpc_cidr_block # Keep SSH restricted to VPC
    from_port  = 22
    to_port    = 22
  }

  # Allow outbound ephemeral ports
  egress {
    protocol   = "tcp"
    rule_no    = 900
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }

  tags = {
    Name = "application-layer-nacl"
  }
}

resource "aws_network_acl_association" "application_layer_private_subnet_1" {
  network_acl_id = aws_network_acl.application_layer.id
  subnet_id      = var.private_subnet_1
}

resource "aws_network_acl_association" "application_layer_private_subnet_2" {
  network_acl_id = aws_network_acl.application_layer.id
  subnet_id      = var.private_subnet_2
}

/* -------------------------------------------------------------------------- */
/*                             Presentation Layer                             */
/* -------------------------------------------------------------------------- */
resource "aws_network_acl" "presentation_layer" {
  vpc_id = var.vpc_id

  # Allow HTTP from anywhere (ALB)
  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

  # Allow HTTPS from anywhere (ALB)
  ingress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }

  # Allow SSH only from VPC (Bastion)
  ingress {
    protocol   = "tcp"
    rule_no    = 300
    action     = "allow"
    cidr_block = var.vpc_cidr_block
    from_port  = 22
    to_port    = 22
  }

  # Allow ephemeral ports from anywhere for return traffic
  ingress {
    protocol   = "tcp"
    rule_no    = 400
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }

  # Allow ICMP for troubleshooting
  ingress {
    protocol   = "icmp"
    rule_no    = 500
    action     = "allow"
    cidr_block = var.vpc_cidr_block
    from_port  = 0
    to_port    = 0
  }

  # Allow HTTP to anywhere
  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

  # Allow HTTPS to anywhere
  egress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }

  # Allow SSH only within VPC
  egress {
    protocol   = "tcp"
    rule_no    = 300
    action     = "allow"
    cidr_block = var.vpc_cidr_block
    from_port  = 22
    to_port    = 22
  }

  # Allow ephemeral ports to anywhere
  egress {
    protocol   = "tcp"
    rule_no    = 400
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }

  # Optional: Allow ICMP for troubleshooting
  ingress {
    protocol   = "icmp"
    rule_no    = 500
    action     = "allow"
    cidr_block = var.vpc_cidr_block
    from_port  = 0
    to_port    = 0
  }
}
