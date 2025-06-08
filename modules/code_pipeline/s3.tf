resource "aws_s3_bucket" "codepipeline_location" {
  bucket = "${var.project_name}-${var.environment}-pipeline-location"

  tags = {
    Name = "Code Pipeline Location"
  }

  force_destroy = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "codepipeline_location" {
  bucket = aws_s3_bucket.codepipeline_location.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "codepipeline_location" {
  bucket = aws_s3_bucket.codepipeline_location.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
