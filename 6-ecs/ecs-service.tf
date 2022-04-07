# ---------------------------------------------------------------------------------------------------------------------
# ECS SERVICE
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_ecs_service" "ecs-codedeploy-service" {
  name                               = local.aws_service_name
  cluster                            = aws_ecs_cluster.fargate-cluster.id
  task_definition                    = aws_ecs_task_definition.fargate-task.family
  desired_count                      = var.task_count
  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200
  health_check_grace_period_seconds  = 300
  launch_type                        = "FARGATE"
  force_new_deployment               = true

  deployment_controller {
    type = "CODE_DEPLOY"
  }
  network_configuration {
    assign_public_ip = true
    security_groups = [
      aws_security_group.ecs_sg.id,
      data.aws_security_group.alb-sg.id
    ]
    subnets = var.vpc_subnets_cidr_blocks
  }
  load_balancer {
    target_group_arn = data.aws_lb_target_group.alb-target-gr.arn
    container_name   = var.family
    container_port   = var.container_port
  }

  tags = merge(
    local.common_tags,
    {
      Name    = local.aws_ecs_cluster_name
      AppRole = "Containers"
    }
  )
}
# ---------------------------------------------------------------------------------------------------------------------
# CLOUDWATCH LOGS GROUP
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_cloudwatch_log_group" "cloudwatchlogs" {
  name = local.aws_cw_log_group
}
