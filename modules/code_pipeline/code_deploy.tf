resource "aws_codedeploy_app" "main" {
  compute_platform = "Server"
  name             = "${var.project_name}-${var.environment}-deploy"
}

resource "aws_codedeploy_deployment_config" "main" {
  deployment_config_name = "${var.project_name}-${var.environment}-deployment-config"

  minimum_healthy_hosts {
    type  = "HOST_COUNT"
    value = 2
  }
}

resource "aws_codedeploy_deployment_group" "main" {
  app_name               = aws_codedeploy_app.main.name
  deployment_group_name  = "${var.project_name}-${var.environment}-deployment-group"
  service_role_arn       = aws_iam_role.codepipeline_role.arn
  deployment_config_name = aws_codedeploy_deployment_config.main.id

  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "BLUE_GREEN"
  }

  autoscaling_groups = [var.autoscaling_group_name]

  load_balancer_info {
    target_group_info {
      name = var.alb_target_group_name
    }
  }

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }


  blue_green_deployment_config {
    deployment_ready_option {
      action_on_timeout    = "STOP_DEPLOYMENT"
      wait_time_in_minutes = 60
    }

    green_fleet_provisioning_option {
      action = "DISCOVER_EXISTING"
    }

    terminate_blue_instances_on_deployment_success {
      action = "KEEP_ALIVE"
    }
  }
}