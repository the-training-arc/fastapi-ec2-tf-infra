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

  key_name = aws_key_pair.generated_key.key_name

  metadata_options {
    http_tokens = "required"
  }

  user_data = base64encode(templatefile("${path.module}/init.sh", {
    ENVIRONMENT        = var.environment
    PROJECT_NAME       = var.project_name
    ECR_REPOSITORY_URL = var.ecr_repository_url
  }))

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${local.resource_prefix}-web-launch-template"
      Role = "application"
    }
  }
}

resource "aws_instance" "bastion_host" {
  ami                         = var.amazon_linux_ami
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet_1
  vpc_security_group_ids      = [var.bastion_security_group_id]
  iam_instance_profile        = aws_iam_instance_profile.bastion.name
  key_name                    = aws_key_pair.generated_key.key_name
  associate_public_ip_address = false

  root_block_device {
    encrypted = true
  }

  metadata_options {
    http_tokens            = "required"
    instance_metadata_tags = "enabled"
  }

  tags = {
    Name = "${local.resource_prefix}-bastion-host"
    Role = "bastion"
  }
}
