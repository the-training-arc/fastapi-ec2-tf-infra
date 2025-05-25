resource "aws_ecr_repository" "fastapi_app" {
  name                 = "${local.resource_prefix}/fastapi-app"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
  force_delete = true
}