resource "aws_autoscaling_group" "web_asg" {
  name = "${local.resource_prefix}-web-asg"

  max_size = 3
  min_size = 2

  health_check_grace_period = 300
  health_check_type         = "ELB"

  launch_template {
    id      = aws_launch_template.web_launch_template.id
    version = aws_launch_template.web_launch_template.latest_version
  }

  vpc_zone_identifier = [
    var.private_subnet_1,
    var.private_subnet_2,
  ]

  instance_refresh {
    strategy = "Rolling"
  }

  dynamic "tag" {
    for_each = {
      Name        = "${local.resource_prefix}-web-asg"
      Environment = var.environment
      Project     = var.project_name
    }

    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}

resource "aws_autoscaling_attachment" "web_asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.web_asg.name
  lb_target_group_arn    = aws_lb_target_group.web_tg.arn

  depends_on = [
    aws_autoscaling_group.web_asg,
    aws_lb_target_group.web_tg
  ]
}

resource "aws_autoscaling_policy" "web_asg_policy" {
  name                   = "${local.resource_prefix}-web-asg-policy"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.web_asg.name
}
