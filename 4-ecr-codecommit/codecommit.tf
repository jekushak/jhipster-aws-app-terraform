# ---------------------------------------------------------------------------------------------------------------------
# CodeCommit
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_codecommit_repository" "codecommit_repo" {
  repository_name = local.aws_codecommit_name
  tags = merge(
    local.common_tags,
    {
      Name    = local.aws_codecommit_name
      AppRole = "Developer Tools"
    }
  )
}
