# ---------------------------------------------------------------------------------------------------------------------
# Codedeploy
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_codedeploy_app" "codedeploy" {
  name             = local.aws_codedeploy_name
  compute_platform = var.compute_platform
  tags = merge(
    local.common_tags,
    {
      Name    = local.aws_codedeploy_name
      AppRole = "Devepoler Tools"
    }
  )
}
resource "aws_codedeploy_deployment_group" "deploy-group" {
  app_name               = aws_codedeploy_app.codedeploy.name
  deployment_group_name  = local.aws_codedeploy_group_name
  service_role_arn       = aws_iam_role.role-for-ecs-codedeploy.arn
  deployment_config_name = "CodeDeployDefault.ECSAllAtOnce"
  ecs_service {
    cluster_name = var.ecs_cluster_name
    service_name = var.ecs_service_name
  }
  blue_green_deployment_config {
    deployment_ready_option {
      action_on_timeout = "CONTINUE_DEPLOYMENT"
    }

    terminate_blue_instances_on_deployment_success {
      action                           = "TERMINATE"
      termination_wait_time_in_minutes = 5
    }
  }
  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "BLUE_GREEN"
  }
  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }

  load_balancer_info {
    target_group_pair_info {
      prod_traffic_route {
        listener_arns = [var.listener_arn]
      }

      target_group {
        name = var.alb_target_group_arn[1]
      }

      target_group {
        name = var.alb_target_group_arn[0]
      }
    }
  }
}
resource "aws_sns_topic" "sns" {
  name = "example-topic"
}
























