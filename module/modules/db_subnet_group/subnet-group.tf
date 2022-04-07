# ---------------------------------------------------------------------------------------------------------------------
# DB Subnet Group
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_db_subnet_group" "subnets-group" {
  name       = local.aws_db_subnetsgroup
  subnet_ids = var.db_subnet_group_subnet_ids
  tags = merge(
    local.common_tags,
    {
      Name    = local.aws_db_subnetsgroup
      AppRole = "Containers"
    }
  )
  lifecycle {
    create_before_destroy = false
  }

}
