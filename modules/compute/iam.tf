resource "aws_iam_role" "ssm_role" {
  name = "${local.resource_prefix}-ssm-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ssm_attach" {
  role       = aws_iam_role.ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "ec2_ssm_attach" {
  role       = aws_iam_role.ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
}

resource "aws_iam_role_policy_attachment" "rds_attach" {
  role       = aws_iam_role.ssm_role.name
  policy_arn = aws_iam_policy.rds_policy.arn
}

resource "aws_iam_role_policy_attachment" "ssm_parameter_store_attach" {
  role       = aws_iam_role.ssm_role.name
  policy_arn = aws_iam_policy.ssm_parameter_store_policy.arn
}

resource "aws_iam_policy" "rds_policy" {
  name = "${local.resource_prefix}-rds-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "rds:DescribeDBInstances",
          "rds:DescribeDBClusters",
          "rds:DescribeDBSubnetGroups",
          "rds:ConnectToInstance"
        ]
        Resource = [var.rds_instance_arn]
      }
    ]
  })
}

resource "aws_iam_policy" "ssm_parameter_store_policy" {
  name = "${local.resource_prefix}-ssm-parameter-store-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ssm:GetParameter",
          "ssm:GetParameters"
        ]
        Resource = [
          "arn:aws:ssm:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:parameter/${var.project_name}/${var.environment}/database/*"
        ]
      }
    ]
  })
}

data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

resource "aws_iam_instance_profile" "ssm_profile" {
  name = "${local.resource_prefix}-ssm-profile"
  role = aws_iam_role.ssm_role.name
}