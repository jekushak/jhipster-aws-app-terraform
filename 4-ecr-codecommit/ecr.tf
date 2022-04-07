# ---------------------------------------------------------------------------------------------------------------------
# ECR
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_ecr_repository" "aws_ecr_repo" {
  name                 = local.aws_ecr_name
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
  tags = merge(
    local.common_tags,
    {
      Name    = local.aws_ecr_name
      AppRole = "Container"
    }
  )
  lifecycle {
    prevent_destroy = false
  }
}



