# ---------------------------------------------------------------------------------------------------------------------
# ECS CLUSTER
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_ecs_cluster" "fargate-cluster" {
  name = local.aws_ecs_cluster_name
  tags = merge(
    local.common_tags,
    {
      Name    = local.aws_ecs_cluster_name
      AppRole = "Containers"
    }
  )
}

