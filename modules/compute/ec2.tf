resource "aws_launch_template" "web_launch_template" {
  name = "${local.resource_prefix}-web-launch-template"

  iam_instance_profile {
    name = aws_iam_instance_profile.ssm_profile.name
  }

  image_id = var.amazon_linux_ami

  instance_initiated_shutdown_behavior = "terminate"

  instance_type = var.instance_type

  monitoring {
    enabled = true
  }

  vpc_security_group_ids = [var.ec2_security_group_id]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${local.resource_prefix}-web-launch-template"
    }
  }

  key_name = aws_key_pair.generated_key.key_name

  user_data = filebase64("${path.module}/init.sh")
}

resource "aws_instance" "bastion_host" {
  ami                         = var.amazon_linux_ami
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet_1
  vpc_security_group_ids      = [var.bastion_security_group_id]
  iam_instance_profile        = aws_iam_instance_profile.ssm_profile.name
  key_name                    = aws_key_pair.generated_key.key_name
  associate_public_ip_address = true

  tags = {
    Name = "${local.resource_prefix}-bastion-host"
  }
}