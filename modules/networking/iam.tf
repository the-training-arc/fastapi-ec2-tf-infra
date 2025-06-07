resource "aws_iam_role" "flow_log_role" {
  name = "${local.resource_prefix}-flow-log-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "vpc-flow-logs.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

data "aws_iam_policy_document" "flow_log_role_policy" {
  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
    ]

    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "flow_log_role_policy" {
  name   = "${local.resource_prefix}-flow-log-role-policy"
  role   = aws_iam_role.flow_log_role.id
  policy = data.aws_iam_policy_document.flow_log_role_policy.json
}
