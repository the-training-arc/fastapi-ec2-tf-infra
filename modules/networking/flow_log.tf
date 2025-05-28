resource "aws_flow_log" "main" {
  iam_role_arn    = aws_iam_role.flow_log_role.arn
  log_destination = aws_cloudwatch_log_group.flow_log_group.arn
  traffic_type    = "ALL"
  vpc_id          = aws_vpc.main_vpc.id

  depends_on = [
    aws_cloudwatch_log_group.flow_log_group,
    aws_iam_role.flow_log_role,
  ]
}

resource "aws_cloudwatch_log_group" "flow_log_group" {
  name              = "${local.resource_prefix}-flow-log-group"
  retention_in_days = 30

  skip_destroy = false
}

resource "null_resource" "delete_log_group" {
  depends_on = [aws_cloudwatch_log_group.flow_log_group]

  triggers = {
    log_group_name = "${local.resource_prefix}-flow-log-group"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "aws logs delete-log-group --log-group-name ${self.triggers.log_group_name}"
  }
}
