resource "aws_instance" "web_1" {
  ami                         = var.amazon_linux_ami
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.ec2_sg.id]
  subnet_id                   = aws_subnet.public_subnet_1.id
  availability_zone           = "ap-southeast-1a"
  iam_instance_profile        = aws_iam_instance_profile.ssm_profile.name
  associate_public_ip_address = true

  user_data = file("./modules/init.sh")
  tags = {
    Name = "${local.resource_prefix}-web-1"
  }
}

resource "aws_instance" "web_2" {
  ami                         = var.amazon_linux_ami
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.ec2_sg.id]
  subnet_id                   = aws_subnet.public_subnet_2.id
  availability_zone           = "ap-southeast-1b"
  iam_instance_profile        = aws_iam_instance_profile.ssm_profile.name
  associate_public_ip_address = true

  user_data = file("./modules/init.sh")

  tags = {
    Name = "${local.resource_prefix}-web-2"
  }
}
