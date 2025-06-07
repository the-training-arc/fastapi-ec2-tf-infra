resource "aws_s3_bucket" "codepipeline_location" {
  bucket = "${var.project_name}-${var.environment}-pipeline-location"

  tags = {
    Name = "Code Pipeline Location"
  }

  force_destroy = true
}
