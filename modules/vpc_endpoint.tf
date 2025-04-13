# ================================
# SSM VPC ENDPOINT
# ================================
resource "aws_vpc_endpoint" "ssm" {
  vpc_id             = aws_vpc.main_vpc.id
  service_name       = "com.amazonaws.ap-southeast-1.ssm"
  vpc_endpoint_type  = "Interface"
  subnet_ids         = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]
  security_group_ids = [aws_security_group.ec2_sg.id]

  tags = {
    Name = "${local.resource_prefix}-ssm"
  }
}

resource "aws_vpc_endpoint" "ssmmessages" {
  vpc_id             = aws_vpc.main_vpc.id
  service_name       = "com.amazonaws.ap-southeast-1.ssmmessages"
  vpc_endpoint_type  = "Interface"
  subnet_ids         = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]
  security_group_ids = [aws_security_group.ec2_sg.id]

  tags = {
    Name = "${local.resource_prefix}-ssmmessages"
  }
}

resource "aws_vpc_endpoint" "ec2messages" {
  vpc_id             = aws_vpc.main_vpc.id
  service_name       = "com.amazonaws.ap-southeast-1.ec2messages"
  vpc_endpoint_type  = "Interface"
  subnet_ids         = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]
  security_group_ids = [aws_security_group.ec2_sg.id]

  tags = {
    Name = "${local.resource_prefix}-ec2messages"
  }
}