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

  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${local.resource_prefix}-web-launch-template"
    }
  }

  user_data = filebase64("${path.module}/init.sh")
}