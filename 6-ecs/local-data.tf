locals {
  app_service                 = "tennis"
  environment                 = "dev"
  cost_centre                 = "devops"
  project                     = "slp"
  owner                       = "zhenishgul"
  region                      = "eu-north-1"
  aws_service_name            = "ecs-${local.app_service}-${local.environment}-service-${local.project}"
  aws_ecs_cluster_name        = "ecs-${local.app_service}-${local.environment}-cluster-${local.project}"
  aws_ecs_security_gr_name    = "ecs-${local.app_service}-${local.environment}-securitygroup${local.project}"
  aws_cw_log_group            = "cw-${local.app_service}-${local.environment}-logs-${local.project}"
  aws_role_for_task_execution = "iam-role-${local.app_service}-${local.environment}-taskexecution-${local.project}"
  aws_role_for_task           = "iam-role-${local.app_service}-${local.environment}-task-${local.project}"
  aws_role_for_ecs_instance   = "iam-role-${local.app_service}-${local.environment}-ecsinstance--${local.project}"
  aws_policy_for_task_execute = "iam-policy-${local.app_service}-${local.environment}-taskexecution-${local.project}"
  aws_policy_for_ecs_instance = "iam-policy-${local.app_service}-${local.environment}-ecsinstance-${local.project}"

  common_tags = {
    environment = local.environment
    project     = local.project
    cost_centre = local.cost_centre
    owner       = local.owner
  }
}
data "aws_security_group" "alb-sg" {
  id = var.alb_security_group_id
}
data "aws_ecr_repository" "ecr-repo" {
  name = "xxxx"
}
data "aws_lb_target_group" "alb-target-gr" {
  name = var.alb_tg_name
  arn  = var.alb_tg_arn
}
